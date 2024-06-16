# Create the elastic beanstalk application
resource "aws_elastic_beanstalk_application" "app-name" {
  name        = var.appname
}


# Create the application version
resource "aws_elastic_beanstalk_application_version" "eb_version" {
  name        = var.content
  application = aws_elastic_beanstalk_application.app-name.name
  bucket      = var.bucket-id
  key         = var.bucket-object
}





