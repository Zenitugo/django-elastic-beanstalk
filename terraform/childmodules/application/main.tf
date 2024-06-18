# Create the elastic beanstalk application
resource "aws_elastic_beanstalk_application" "app-name" {
  name        = var.appname
}


# Create the application version
resource "aws_elastic_beanstalk_application_version" "eb_version" {
  for_each = { for i, v in var.bucket-object : i => v }
  name        = "beanstalk-v1.0.0"
  application = aws_elastic_beanstalk_application.app-name.name
  bucket      = var.bucket-id
  key         = each.value
}





