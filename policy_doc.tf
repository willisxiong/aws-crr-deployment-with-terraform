# Set Pemmission for replication can refer to 
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/setting-repl-config-perm-overview.html

data "aws_iam_policy_document" "replicate_to_hk" {
  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.sg.arn}"]
  }
  statement {
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.sg.arn}/*"]
  }
  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.hk.arn}/*"]
  }
}

data "aws_iam_policy_document" "replicate_to_sg" {
  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.hk.arn}"]
  }
  statement {
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.hk.arn}/*"]
  }
  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.sg.arn}/*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    effect = "Allow"
  }
}