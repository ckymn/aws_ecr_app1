terraform {
  backend "s3" {
    bucket         = "devops-case-s3-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "devops-case-s3-bucket-locks"
  }
}
