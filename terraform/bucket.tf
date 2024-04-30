resource "aws_s3_bucket" "mybucket" {
  bucket = "bispo-testando-devops-ifmt"
  
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket                  = aws_s3_bucket.mybucket.id
  depends_on = [
    aws_s3_bucket.mybucket
  ]
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



resource "aws_s3_bucket_website_configuration" "mybucket" {
  bucket     = aws_s3_bucket.mybucket.id
  depends_on = [
    aws_s3_bucket.mybucket,
    aws_s3_bucket_public_access_block.mybucket,
    ]

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id

  acl = "public-read"
  depends_on = [
    aws_s3_bucket_ownership_controls.site,
    aws_s3_bucket_public_access_block.mybucket
  ]
}

resource "aws_s3_bucket_policy" "meubucket_policy" {
  bucket     = aws_s3_bucket.mybucket.id
  depends_on = [
    aws_s3_bucket.mybucket,
    aws_s3_bucket_public_access_block.mybucket,
    aws_s3_bucket_website_configuration.mybucket,
  ]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject"
        Resource  = [
          aws_s3_bucket.mybucket.arn,
          "${aws_s3_bucket.mybucket.arn}/*"
          ]
      },
    ]
  })
}

resource "aws_s3_bucket_versioning" "my-versioning" {
  bucket     = aws_s3_bucket.mybucket.id
  depends_on = [
    aws_s3_bucket.mybucket,
    aws_s3_bucket_public_access_block.mybucket,
    aws_s3_bucket_website_configuration.mybucket,
    aws_s3_bucket_policy.meubucket_policy,
  ]
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "upload_files" {
  # Usar for para excluir arquivos começados por ponto
  for_each = { for f in fileset("${path.module}/../site", "**/*") : f => f if !startswith(basename(f), ".") }

  bucket = aws_s3_bucket.mybucket.id
  key    = each.value
  source = "${path.module}/../site/${each.value}"
  //confere as dependencias
  depends_on = [
    aws_s3_bucket.mybucket,
    aws_s3_bucket_versioning.my-versioning
  ]
}

