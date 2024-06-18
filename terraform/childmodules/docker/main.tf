terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}
# Build docker images
 resource "docker_image" "image" {
   name = "${var.ecr_uri}:latest"

   build  {
    context = "../../../django-elastic-beanstalk"
     dockerfile = "Dockerfile"
   }

   depends_on = [ var.ecr_uri ]
 }

# Login to ecr repo
 resource "null_resource" "login_to_ecr" {
   provisioner "local-exec" {
     command = <<EOF
     aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.ecr_uri}

     docker push ${var.ecr_uri}:latest
   EOF
  
   }
   depends_on = [ docker_image.image ]

 } 



# Create docker run configuration file. This code writes the content into the Dockerrun.aws.json file
resource "local_file" "docker_run_config" {
  depends_on = [docker_image.image]

    content = jsonencode({
    "AWSEBDockerrunVersion": "1",
    "Image": {
        "Name": var.ecr_uri
        "Update": "true"
    },
    "Ports": [
        {
            "ContainerPort": 8000,
            "HostPort": 80
        }
    ],
    "Volumes": [
        {
          "HostDirectory": "/var/app/current",
          "ContainerDirectory": "/var/www/html"
        }
    ],
    "Logging": "/var/log/nginx"
})


    filename = "${path.module}/Dockerrun.aws.json"
} 


