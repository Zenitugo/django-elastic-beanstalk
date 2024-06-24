# Compress .ebextensions directory
data "archive_file" "nginx_config" {
    type             = "zip"
    source_file      = "${path.module}/.ebextensions/nginx.config"
    output_path      = "${path.module}/.ebextensions/nginx.config.zip"
}

# External data source to capture the version label from the output file
data "external" "version_label" {
  program = ["sh", "-c", "jq -r '.ApplicationVersion.VersionLabel' output.json"]
}