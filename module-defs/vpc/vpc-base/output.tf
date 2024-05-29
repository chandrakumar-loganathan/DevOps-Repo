output "vpcid" {
  value = aws_vpc.vpc.id
}
output "subnet_1" {
  value = aws_subnet.private_subnet_1.*.id
}
output "subnet_2" {
  value = aws_subnet.private_subnet_2.*.id
}
output "subnet_3" {
  value = aws_subnet.private_subnet_3.*.id
}
output "public_subnet" {
  value = aws_subnet.public_subnet.*.id
}
