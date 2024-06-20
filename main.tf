resource "aws_s3_bucket" "source" {
  bucket   = var.source_bucket_name
  provider = aws.source

}

resource "aws_s3_bucket_versioning" "source" {
  provider = aws.source
  bucket   = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}


data "aws_caller_identity" "destination" {
  provider = aws.destination
}

resource "aws_s3_bucket_replication_configuration" "replication_config" {
  provider = aws.source
  bucket   = aws_s3_bucket.source.id
  role     = aws_iam_role.replication.arn

  rule {
    id     = "ReplicationRule"
    status = "Enabled"

    destination {
      account       = data.aws_caller_identity.destination.account_id
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
  }
  depends_on = [aws_s3_bucket_versioning.source]
}

resource "aws_iam_role" "replication" {
  provider = aws.source
  name     = var.replication_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "replication" {
  provider = aws.source
  name     = var.iam_replication_policy_name
  role     = aws_iam_role.replication.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ],
        Resource = [
          "${aws_s3_bucket.source.arn}"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl"
        ],
        Resource = [
          "${aws_s3_bucket.source.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        Resource = [
          "${aws_s3_bucket.destination.arn}/*"
        ]
      }
    ]
  })

}

resource "aws_s3_bucket" "destination" {
  provider = aws.destination
  bucket   = var.destination_bucket_name

}

resource "aws_s3_bucket_versioning" "destination" {
  provider = aws.destination
  bucket   = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}





resource "aws_s3_bucket_policy" "destination_bucket_policy" {
  provider = aws.destination
  bucket   = aws_s3_bucket.destination.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "${aws_iam_role.replication.arn}"
        }
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ]
        Resource = "${aws_s3_bucket.destination.arn}/*"
      }
    ]
  })
}
