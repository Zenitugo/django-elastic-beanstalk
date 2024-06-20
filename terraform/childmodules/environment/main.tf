resource "aws_elastic_beanstalk_environment" "app-env" {
  name                = var.env
  application         = var.app-name 
  solution_stack_name = var.solution_stack
  cname_prefix        = var.cname_prefix  


  setting {
    namespace = "aws:autoscaling:launchconfiguration" 
    name      = "IamInstanceProfile"
    value     = var.ec2-profile

  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration" 
    name      = "InstanceType"
    value     = var.instance_type

  }

  setting {
    namespace = "aws:autoscaling:asg" 
    name      = "MaxSize"
    value     = var.max_instance_count

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
  
 depends_on = [ var.login ]
}