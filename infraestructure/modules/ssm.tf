data "aws_iam_policy_document" "ec2_config_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm" {
  name               = var.infrastructure_config.ssm.role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_config_role.json
  tags               = var.infrastructure_config.tags
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = var.infrastructure_config.ssm.managed_policy_arn
}

resource "aws_iam_instance_profile" "ssm" {
  name = var.infrastructure_config.ssm.instance_profile_name
  role = aws_iam_role.ssm.name
  tags = var.infrastructure_config.tags
}
