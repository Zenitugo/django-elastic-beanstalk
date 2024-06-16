# Create buckets to store docker run configuration files
resource "aws_s3_bucket" "docker-buckets" {
    bucket = var.bucket-name
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [aws_s3_bucket.docker-buckets]

  bucket = aws_s3_bucket.docker-buckets.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  depends_on = [ aws_s3_bucket_acl.bucket-acl]  
  bucket = aws_s3_bucket.docker-buckets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# Store the archive file in the S3 bucket
resource "aws_s3_object" "archive_file" {
  bucket = aws_s3_bucket.docker-buckets.id
  key    = "${sha256(var.content)}.zip"
  source = var.archive
}


# Store the nginx-config file
resource "aws_s3_object" "nginx-config" {
  bucket = aws_s3_bucket.docker-buckets.id
  key    = "${sha256(var.nginx-content)}.zip"
  source = var.nginx-config
}