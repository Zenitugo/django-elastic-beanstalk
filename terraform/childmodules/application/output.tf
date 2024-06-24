# Ouput the application name
output "app-name" {
    value = aws_elastic_beanstalk_application.app-name.name
}
    


#Output the nginx configurationfile
output "nginx-config" {
    value = data.archive_file.nginx_config.output_path
}

output "nginx-content" {
    value = data.archive_file.nginx_config.source_file
}

