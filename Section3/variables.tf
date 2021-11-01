variable "region" {
    default =  "us-east-2"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
      "Name" = ""
  }
}