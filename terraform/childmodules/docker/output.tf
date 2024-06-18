# Output the zip file
output "archive" {
    value = data.archive_file.docker_run.output_path
  
}

# Output the content of the docker run config file
output "content" {
    value = local_file.docker_run_config.content
}


# Output login
output "login" {
    value = null_resource.login_to_ecr
}