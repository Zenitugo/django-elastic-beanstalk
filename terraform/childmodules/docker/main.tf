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
    context = "../../../Beanstalk"
     dockerfile = "Dockerfile"
   }
 }

 resource "null_resources" "image" {
      provisioner "local-exec" {
    command = <<EOF
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
    gradle build -p noiselesstech
    docker build -t "${aws_ecr_repository.noiselesstech.repository_url}:latest" -f noiselesstech/Dockerfile .
    docker push "${aws_ecr_repository.noiselesstech.repository_url}:latest"
    EOF
  }


  triggers = {
    "run_at" = timestamp()
  }


  depends_on = [
    aws_ecr_repository.noiselesstech,
  ]

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


