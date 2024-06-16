resource "aws_elastic_beanstalk_environment" "app-env" {
  name                = var.env
  application         = var.app-name
  solution_stack_name = var.solution_stack
  version_label       = var.beanstalk-version
  cname_prefix        = var.cname_prefix  

  setting {
    name      = "Instance profile"
    namespace = "aws:autoscaling:launchconfiguration" 
    value     = var.ec2-profile

  }

    setting {
    name      = "Instance type"
    namespace = "aws:autoscaling:launchconfiguration" 
    value     = var.instance_type

  }

    setting {
    name      = "Loadbalancer-type"
    namespace = "aws:elasticbeanstalk:environment"
    value     = var.loadbalancer

  }

    setting {
    name      = "elbs-scheme"
    namespace = "aws:ec2:vpc"
    value     = var.elb-scheme

  }

    setting {
      name      = "tier"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "webserver"
    } 

    setting {
      name      = "healthcheckpath"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     =  "/"
    }

    dynamic "setting" {
    for_each = var.env_variable
    content {
      namespace = "aws:elasticbeanstalkenvironment:application:environment"
      name = setting.key
      value = setting.value
    }
}
}