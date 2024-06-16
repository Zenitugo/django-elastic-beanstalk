#Output instance profile
output "ec2-profile" {
    value = aws_iam_instance_profile.iam-role.name
}