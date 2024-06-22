#Output bucket id
output "bucket-id"{
    value = aws_s3_bucket.docker-buckets.id
}


#Output s3 object keys
output "bucket-object1" {
  value =  aws_s3_object.nginx-config.key
}

output "bucket-object2" {
  value = aws_s3_object.archive_file.key
}