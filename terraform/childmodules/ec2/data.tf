data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "permissions" {
    statement {
        actions = [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "cloudwatch:putmetricdata",
            "ec2:DescribeInstanceStatus",
            "ssm:*",
            "ec2messages:*",
            "s3:*",
            "sqs:*",
        ]
        resources = ["*"]
    }
}



