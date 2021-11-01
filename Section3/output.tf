output "vpc_cidr" {
  value = var.vpc_cidr
}
output "aws_subnet" {
  value = aws_subnet.public
}