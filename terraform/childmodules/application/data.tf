# Compress .ebextensions directory
data "archive_file" "nginx_config" {
    type             = "zip"
    source_file      = "${path.module}/.ebextensions/nginx.config"
    output_path      = "${path.module}/.ebextensions/nginx.config.zip"
}