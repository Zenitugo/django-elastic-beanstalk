# Local variable to determine the instance profile name
locals {
 ec2_profile_name = length(data.aws_iam_instance_profile.existing.id) == 0 ? aws_iam_instance_profile.iam-role[count.index].name : data.aws_iam_instance_profile.existing.name
} 