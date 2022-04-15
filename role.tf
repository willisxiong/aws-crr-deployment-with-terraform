resource "aws_iam_role" "replicate_to_sg_role" {
  name = "s3-cross-region-replication-to-sg"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "replicate_to_sg_policy" {
  name = "s3-crr-role-policy-replication-to-sg"
  policy = data.aws_iam_policy_document.replicate_to_sg.json
}

resource "aws_iam_role_policy_attachment" "attachment-a" {
  role       = aws_iam_role.replicate_to_sg_role.name
  policy_arn = aws_iam_policy.replicate_to_sg_policy.arn
}

resource "aws_iam_role" "replicate_to_hk_role" {
  name = "s3-cross-region-replication-to-hk"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "replicate_to_hk_policy" {
  name = "s3-crr-role-policy-replication-to-hk"
  policy = data.aws_iam_policy_document.replicate_to_hk.json
}

resource "aws_iam_role_policy_attachment" "attachment-b" {
  role       = aws_iam_role.replicate_to_hk_role.name
  policy_arn = aws_iam_policy.replicate_to_hk_policy.arn
}