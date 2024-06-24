# Create the elastic beanstalk application
resource "aws_elastic_beanstalk_application" "app-name" {
  name        = var.appname
}


# Create application version
resource "null_resource" "deploy_application" {
  provisioner "local-exec" {
    command = <<-EOT
      aws elasticbeanstalk create-application-version --application-name ${aws_elastic_beanstalk_application.app-name.name} \
      --version-label ${var.version_name} \
      --source-bundle S3Bucket=${var.bucket-id},S3Key=${var.bucket-object1} \
      --source-bundle S3Bucket=${var.bucket-id},S3Key=${var.bucket-object2} 

    EOT

    # Capture the version label from the command output
    interpreter = ["bash", "-c"]
    environment = {
      VERSION_LABEL = "${var.version_name}"
    }
  }
  
  depends_on = [aws_elastic_beanstalk_application.app-name,
                var.bucket-object1,
                var.bucket-object2 ]
             
                
}






