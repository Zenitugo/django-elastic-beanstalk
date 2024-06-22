module "application" {
    source            = "../childmodules/application"
    appname           = var.appname
    bucket-id         = module.s3.bucket-id
    version_name      = var.version_name 
    bucket-object1    = module.s3.bucket-object1
    bucket-object2    = module.s3.bucket-object2  
 }


module "environment" {
    source            = "../childmodules/environment"
    env               = var.env
    app-name          = module.application.app-name
    solution_stack    = var.solution_stack 
    cname_prefix      = var.cname_prefix 
    ec2-profile       = module.ec2.ec2-profile
    instance_type     = var.instance_type 
    loadbalancer      = var.loadbalancer
    elb-scheme        = var.elb-scheme
    env_variable      = var.env_variable
    login             = module.docker.login 
    max_instance_count = var.max_instance_count
    version-label     = module.application.version-label 
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