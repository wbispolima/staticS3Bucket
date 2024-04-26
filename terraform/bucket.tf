resource "aws_s3_bucket" "mybucket" {
  bucket = "ifmt-devops-profbispo01"
}

resource "aws_s3_bucket_website_configuration" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "meubucket_policy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.mybucket.arn}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybucket.id
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
  depends_on = [
    aws_s3_bucket.mybucket,
  ]
}
