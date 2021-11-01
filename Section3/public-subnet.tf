# data.aws_availability_zone.azones.names[0] gives first list of entry
# data.aws_availability_zone.azones.names gives all the entries in the list
# data.aws_availability_zone.azones.names are using any times so we used in locals
# cidrsubnet(10.0.0.0/16, 8, 1)
# it takes the cidr block 16 and adds 8 (16+8=24) then it becomes 10.0.0.0/24
# 1 here subnet cidr
# 10.0.0.0/16 ---10.0.1.0/24 (first iteration)
# 10.0.1.0/24 --- 10.0.2.0/24

locals {
  azones_names = "${data.aws_availability_zone.azones.names}"
}

resource "aws_subnet" "public" {
  count = "${length(local.azones_names)}"
  vpc_id = "${aws_vpc.myjavavpc.id}"
  availability_zone = "${local.azones_names[count.index]}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  tags = {
    # index starts from 0 so we are adding +1 to it so it's starts from 1 not from 0
    "Name" = "PublicSubnet=${count.index + 1}"
  }
}