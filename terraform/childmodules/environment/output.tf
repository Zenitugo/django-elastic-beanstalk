#Output the cname of the environment
output "cname" {
    value = aws_elastic_beanstalk_environment.app-env.cname
}