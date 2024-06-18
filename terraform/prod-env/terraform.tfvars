region                   = "eu-central-1"
appname                  = "votingApp"
profile                  = "default" 
env                      = "app-prod-env" 
ecr-name                 = "rubby"
bucket-name              = "dockerrun-config-bucket"
iam_role                 = "ec2-iam-role" 
iam_profile              = "ec2-iam-profile" 
permissions              = "role-permissions"
solution_stack           = "64bit Amazon Linux 2023 v4.3.3 running Docker"
cname_prefix             = "zenitugo"  
instance_type            = "t3.medium" 
loadbalancer             = "Application"
elb-scheme               = "Internet facing"
env_variable             = {
    DJANGO_SETTINGS_MODULE = "my_app.settings"
    PYTHONPATH             = "/opt/python/current/app/my_app"
}
dockerfile_path          = "../childmodules/terraform/Dockerfile"
max_instance_count       = 2

