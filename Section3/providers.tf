provider "aws"{
    region = "${var.region}"
}
terraform {
    backend "s3"{
        bucket = "javahomesection3"
        key = "terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "javahomesam"
    }
}