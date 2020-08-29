variable "AWS_ACCESS_KEY_ID" {
    default = "$(aws configure get aws_access_key_id)"
    }
variable "AWS_SECRET_ACCESS_KEY" {
    default = "$(aws configure get aws_secret_access_key)"
    }
variable "aws_region" {
    default = "$(aws configure get region)"
    }

variable "key_name" {
    default = "user"
    }
variable "user" { 
    default = "ec2-user"
    }

variable "aws_existed_key_name" {
  default = "../../../../../Downloads/keys/user.pem"
}

variable "owner" {
  description = "Infra Owner"
  default = "Me"
    } 
variable "environment" {
  description = "Test Infra"
  default = "Test-VM"
    }

