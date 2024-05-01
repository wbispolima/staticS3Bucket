variable "content_types" {
  description = "Map of file extensions to MIME types"
  type        = map(string)
  default     = {
    "gif"  = "image/gif",
    "html" = "text/html",
    "css"  = "text/css"
  }
}