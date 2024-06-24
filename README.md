# DEPLOYMENT OF A DJANGO APPLICATION ON AWS ELASTIC BEANSTALK
This project was done to improve my knowledge in utilising AWS offering to deploy applications.
The source code for the python application can be found [here](https://github.com/SuryaPratap2542/Voting-Site)

**To see how to deploy django app on AWS Elastic Beanstalk using AWS CLI read this article I wrote on**
[Hashnode](https://dhebbydavid.hashnode.dev/deployment-of-a-django-application-on-aws-elasticbeanstalk-using-aws-cli)

## PRE-REQUISITE
The article has higlighted the pre-requisites to have, the only difference here is that `Terraform` was installed as this repository talks about using terraform to create Beanstalk infrastructure and the necessay resources required by Beanstalk such EC2 and S3 buckets


## DEPLOYMENT ARCHITECTURE

![architecture](./images/voting-app%20(2).png)

## Terraform
Terraform tool was used to provision the docker image build and push to Amazon Elastic Container Registry.

**This piece of code was used to build docker image**
```
 resource "docker_image" "image" {
   name = "${var.ecr_uri}:latest"

   build  {
    context = "../../../django-elastic-beanstalk"
     dockerfile = "Dockerfile"
   }

   depends_on = [ var.ecr_uri ]
 }
```

**This piece of code was used to push docker image to AWS Elastic Container Registry**
```
 resource "null_resource" "login_to_ecr" {
   provisioner "local-exec" {
     command = <<EOF
     aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.ecr_uri}

     docker push ${var.ecr_uri}:latest
   EOF
  
   }
   depends_on = [ docker_image.image ]

 } 
 ```

 
 This tool was used to create S3 bucket, ec2 instance profile and the elastic beanstalk environment
 **Proof of s3 bucket creation**
 ![s3](./images/s3.png)

 **Proof of ec2 instance created**
 ![ec2](./images/ec2.png)

 **Proof of beanstalk application created**
 ![beanstalk](./images/bean1.png)
 ![beanstalk](./images/bean2.png)


 ## PROOF OF DEPLOYMENT OF DJANGO APP
 ![APP](./images/app.png)








