locals {
  vpc_name = "${terraform.workspace == "dev" ? javaHomeVPC-dev : javahomevpc-prod }"
}

resource "aws_vpc" "javahome" {
  count = "${terraform.workspace == "dev" ? 0 : 1}"
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    "Name" = "${locals.vpc_name}"
    "Env" = "${terraform.workspace}"
  }
}