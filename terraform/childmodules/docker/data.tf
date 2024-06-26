data "aws_caller_identity" "current" {}

# Compress docker run config file
data "archive_file" "docker_run" {
    type             = "zip"
    source_file      = local_file.docker_run_config.filename 
    output_path      = "${path.module}/Dockerrun.aws.zip"
}
