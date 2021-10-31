provider "aws"{
    profile = "terra"
    region = "us-east-2"
}
terraform{
    backend "s3" {
        bucket = "javahomesam"
        key = "terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "javahomesam" 
    }
}
resource "aws_vpc" "javahome" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    "Name" = "JavaHOme"
    "Env" = "Dev"
  }
}
resource "aws_subnet" "javahomesubnet" {
  vpc_id = aws_vpc.javahome.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2b"
}
resource "aws_subnet" "javahomesubnet1" {
  vpc_id = aws_vpc.javahome.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2c"
}


output "javahomecidr" {
  value = "${aws_vpc.javahome.cidr_block}"
  }
output "Vpc_id_value" {
  value = "${aws_vpc.javahome.id}"
}

