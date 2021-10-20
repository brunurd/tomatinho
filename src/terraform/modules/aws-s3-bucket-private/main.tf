resource "aws_s3_bucket" "private_bucket" {
  bucket = var.name
  acl    = "private"

  tags = {
    Name        = var.name
    Environment = var.stage
  }
}

resource "aws_iam_user" "private_bucket_user" {
  name = "DeployerUser${var.stage}"
  path = "/"
  depends_on = [
    aws_s3_bucket.private_bucket
  ]
}

resource "aws_iam_user_policy" "private_bucket_user_policy" {
  name = "DeploymentBucketFullAccessPolicy${var.stage}"
  user = aws_iam_user.private_bucket_user.name
  depends_on = [
    aws_iam_user.private_bucket_user
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.private_bucket.arn,
          "${aws_s3_bucket.private_bucket.arn}/*",
        ]
      },
    ]
  })
}