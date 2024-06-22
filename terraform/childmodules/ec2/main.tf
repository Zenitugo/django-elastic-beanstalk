#Create an instance profile and attach iam roles
resource "aws_iam_instance_profile" "iam-role" {
  count = length(data.aws_iam_instance_profile.existing.id) == 0 ? 1 : 0
  name = var.iam_profile
  role = aws_iam_role.role.name
}


# Create Iam roles
resource "aws_iam_role" "role" {
  name                = var.iam_role
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json

  inline_policy {
   name = var.permissions
   policy = data.aws_iam_policy_document.permissions.json
 }
}

# Mangaed policies
resource "aws_iam_role_policy_attachment" "s3_readonly_access" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_webtier" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_multicontainer" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_workertier" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "ec2_instance_profile_for_image_builder" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
}