/*resource "aws_subnet" "privsub" {
  vpc_id = aws_vpc.myjavavpc.id
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "Privsub"
  }
}
*/

resource "aws_subnet" "privsub" {
  # here we need only two for that we are using slice operation here
  #count = lenght(local.azones_names)
  count = length(slice(local.azones_names, 0, 2))
  # index 0 is 1 and 1 is 2 and 2 is 3
  vpc_id = aws_vpc.myjavavpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 1) + length(local.azones_names)
  availability_zone = local.azones_names[count.index]
  tags = {
    "Name" = "Privsub-${count.index +1 }"
  }

}