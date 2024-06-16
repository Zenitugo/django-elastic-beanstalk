resource "aws_elastic_beanstalk_environment" "app-env" {
  name                = var.env
  application         = var.app-name 
  solution_stack_name = var.solution_stack
  version_label       = var.beanstalk-version
  cname_prefix        = var.cname_prefix  

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration" 
    value     = var.ec2-profile

  }

    setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration" 
    value     = var.instance_type

  }

    setting {
    name      = "LoadBalancerType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = var.loadbalancer

  }

    setting {
    name      = "ELBScheme"
    namespace = "aws:ec2:vpc"
    value     = var.elb-scheme

  }

    setting {
      name      = "healthcheckpath"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     =  "/"
    }

    dynamic "setting" {
    for_each = var.env_variable
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name = setting.key
      value = setting.value
    }
}
}