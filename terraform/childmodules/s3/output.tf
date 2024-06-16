#Output bucket id
output "bucket-id"{
    value = aws_s3_bucket.docker-buckets.id
}


#Output non-empty bucket 
output "bucket-object" {
    value = aws_s3_object.archive_file.id
}