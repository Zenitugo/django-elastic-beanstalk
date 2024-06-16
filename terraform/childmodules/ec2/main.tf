#Create an instance profile and attach iam roles
resource "aws_iam_instance_profile" "iam-role" {
  name = var.iam_profile
  role = aws_iam_role.role.name
}


# Create Iam roles
resource "aws_iam_role" "role" {
  name                = var.iam_role
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
 ]

 inline_policy {
   name = var.permissions
   policy = data.aws_iam_policy_document.permissions.json
 }
}