# Define Output Values

# Attribute Reference: VPC
output "aws_vpc_id_output" {
  description = "VPC ID"
  value       = aws_vpc.anz-tasks-trfm-vpc.id
}

#Subnets
output "aws_subnet_pub1_output" {
  description = "Subnet ID for public subnet1"
  value       = aws_subnet.anz-tasks-trfm-subnet1-pub.id
}
output "aws_subnet_pub2_output" {
  description = "Subnet ID for public subnet2"
  value       = aws_subnet.anz-tasks-trfm-subnet2-pub.id
}