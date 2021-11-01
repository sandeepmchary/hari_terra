resource "aws_vpc" "myjavavpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    "Name" = "${terraform.workspace == "dev" ? "Javahome-dev" : "JavaHome-prod" }"
    "Env" = "${terraform.workspace}"
  }
}