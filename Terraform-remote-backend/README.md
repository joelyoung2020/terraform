# Configuring terraform remote backend
This Terraform configuration stores the terraform.tfstate file in an S3 bucket and perform state-locking using dynamodb_table

## Details
- The S3 bucket where state file will be stored
- The dynamodb Table used for state-locking

Note that you need to set environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
