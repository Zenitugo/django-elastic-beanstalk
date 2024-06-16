module "application" {
    source            = "../childmodules/application"
    appname           = var.appname
    bucket-id         = module.s3.bucket-id
    bucket-object     = module.s3.bucket-object  
}


module "environment" {
    source            = "../childmodules/environment"
    env               = var.env
    app-name          = module.application.app-name
    solution_stack    = var.solution_stack 
    cname_prefix      = var.cname_prefix 
    beanstalk-version = module.application.beanstalk-version
    ec2-profile       = var.ecr-name 
    instance_type     = var.instance_type 
    loadbalancer      = var.loadbalancer
    elb-scheme        = var.elb-scheme
    env_variable      = var.env_variable
}

module "ECR" {
    source            = "../childmodules/ECR"
    ecr-name          = var.ecr-name
}

module "s3" {
    source            = "../childmodules/s3"
    bucket-name       = var.bucket-name 
    archive           = module.docker.archive
    content           = module.docker.content 
    nginx-config      = module.application.nginx-config
    nginx-content     = module.application.nginx-content
}

module "docker" {
    source            = "../childmodules/docker"
    providers  = {
        docker       = docker.kreuzwerker
    }
    region            = var.region
    ecr_uri           = module.ECR.ecr_uri
    dockerfile_path   = var.dockerfile_path  
}

module "ec2" {
  source              = "../childmodules/ec2"
  iam_role            = var.iam_role 
  iam_profile         = var.iam_profile 
  permissions         = var.permissions 
}