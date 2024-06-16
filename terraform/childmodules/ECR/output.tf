#Retrieve the uri of the repository
output "ecr_uri" {
  value = aws_ecr_repository.repo.repository_url
}
