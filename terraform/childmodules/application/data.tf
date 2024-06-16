# Compress .ebextensions directory
data "archive_file" "nginx_config" {
    type             = "zip"
    source_file      = "${path.module}/.ebextensions"
    output_path      = "${path.module}/.ebextensions.zip"
}