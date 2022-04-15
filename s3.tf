resource "aws_s3_bucket" "hk" {
  provider = aws.ap-east-1
  acl = "private"

  bucket = "hk-bucket-bi-directional-replication1001"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "sg" {
  provider = aws.ap-southeast-1
  acl = "private"

  bucket = "sg-bucket-bi-directional-replication1002"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_replication_configuration" "replicate_to_sg" {
  provider = aws.ap-east-1

  depends_on = [aws_s3_bucket.hk]

  role   = aws_iam_role.replicate_to_sg_role.arn
  bucket = aws_s3_bucket.hk.id

  rule {
    id = "tosg"
    filter {

    }
    status = "Enabled"

    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket        = aws_s3_bucket.sg.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_replication_configuration" "replicate_to_hk" {
  provider = aws.ap-southeast-1

  depends_on = [aws_s3_bucket.sg]

  role   = aws_iam_role.replicate_to_hk_role.arn
  bucket = aws_s3_bucket.sg.id

  rule {
    id = "tohk"
    filter {

    }
    status = "Enabled"

    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket        = aws_s3_bucket.hk.arn
      storage_class = "STANDARD"
    }
  }
}

