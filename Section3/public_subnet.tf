# data.aws_availability_zone.azones.names[0] gives first list of entry
# data.aws_availability_zone.azones.names gives all the entries in the list
# data.aws_availability_zone.azones.names are using any times so we used in locals
# cidrsubnet(10.0.0.0/16, 8, 1)
# it takes the cidr block 16 and adds 8 (16+8=24) then it becomes 10.0.0.0/24
# 1 here subnet cidr
# 10.0.0.0/16 ---10.0.1.0/24 (first iteration)
# 10.0.1.0/24 --- 10.0.2.0/24

locals {
  azones_names = "${data.aws_availability_zones.azones.names}"
  pub_sub_rt_assoc = "${aws_subnet.public.*.id}"
  cidr_block_count = "${count.index + length(local.azones_names)}"
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

resource "aws_internet_gateway" "awsigw" {
  vpc_id = "${aws_vpc.myjavavpc.id}"
  tags = {
    "Name" = "JavaHomeIGW"
  }
}
resource "aws_route_table" "PublicRT" {
  vpc_id = "${aws_vpc.myjavavpc.id}"
  route {
          cidr_block = "0.0.0.0/0"
          gateway_id = "${aws_internet_gateway.awsigw.id}"
      }
   tags = {
     "Name" = "PublicRT"
   }
}
resource "aws_route_table_association" "publicrtassoc" {
# get all subnet id here and loop for creation
  count = "${length(local.azones_names)}"
  # public.id is only for one subnet
  # our case is multiple subnets we access them using *
  # this return list of subnet id's we can access one subnet at a time
  # count.index
  # subnet_id = "${aws_subnet.public.id}"
  # * for multiple list
  #  
  subnet_id = "${local.pub_sub_rt_assoc[count.index]}"
  route_table_id = "${aws_route_table.PublicRT.id}"
}
