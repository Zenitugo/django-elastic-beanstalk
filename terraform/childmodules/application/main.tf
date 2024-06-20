# Create the elastic beanstalk application
resource "aws_elastic_beanstalk_application" "app-name" {
  name        = var.appname
}







