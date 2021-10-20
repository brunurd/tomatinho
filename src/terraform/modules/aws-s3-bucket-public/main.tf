resource "aws_s3_bucket" "public_bucket" {
  bucket = var.name
  acl    = "public-read"

  tags = {
    Name        = var.name
    Environment = var.stage
  }
}

resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Principal = "*"
        Resource  = [
          "${aws_s3_bucket.public_bucket.arn}/*",
        ]
      },
    ]
  })
}