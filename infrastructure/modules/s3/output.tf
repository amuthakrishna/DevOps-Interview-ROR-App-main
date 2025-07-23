output "env_s3_bucket_name" {
  description = "The name of the S3 bucket where the env file is stored"
  value       = aws_s3_bucket.env_file_bucket.bucket
}

output "env_s3_key" {
  description = "The key of the uploaded env file"
  value       = aws_s3_object.env_file.key
}
