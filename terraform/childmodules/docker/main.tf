# Build docker images
resource "docker_registry_image" "image" {
  name = "${aws_ecr_repository.repo.repository_url}:latest"

  build  {
    context = ".."
    dockerfile = "Dockerfile"
  }
}



# Create docker run configuration file. This code writes the content into the Dockerrun.aws.json file
resource "local_file" "docker_run_config" {
  depends_on = [docker_registry_image.image]

    content = jsonencode({
    "AWSEBDockerrunVersion": "1",
    "Image": {
        "Name": "930456265944.dkr.ecr.eu-west-1.amazonaws.com/sapphire",
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


