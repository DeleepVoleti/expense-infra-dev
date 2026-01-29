
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }


  backend "s3" {
        bucket = "dilips-bucket-9182"
        key = "expense-dev-infra-01-vpc"
        region = "us-east-1"
        dynamodb_table = "dilips-dynamo-table" 
            }
}


provider "aws" {
  region = "us-east-1"
        
        

}