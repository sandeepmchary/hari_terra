output "vpc_cidr" {
  value = var.vpc_cidr
}
/*output "aws_subnet" {
  value = aws_subnet.public[count.index + 1]
}*/
output "vpc_id" {
  value = aws_vpc.myjavavpc.id
}
output "vpc_owner_id" {
  value = aws_vpc.myjavavpc.owner_id
}
output "PublicRT" {
  value = aws_route_table.PublicRT
}
