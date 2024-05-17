/*
Code in this file does following:
1. This is main file which has networking resources deployed. 
It created VPC, 2 public subnets, Internet gateways, route tables.
*/


# Configure VPC
resource "aws_vpc" "anz-tasks-trfm-vpc" {
  cidr_block = var.anz-tasks-trfm-vpc-cidrblock

  tags = {
    "Name"      = "anz-tasks-trfm-vpc"
  }
}

# Configure Subnets - 2 Public Subnets
resource "aws_subnet" "anz-tasks-trfm-subnet1-pub" {
  cidr_block        = var.anz-tasks-trfm-subnet1-cidrblock
  availability_zone = var.anz-tasks-trfm-subnet1-azone
  vpc_id            = aws_vpc.anz-tasks-trfm-vpc.id

  tags = {
    "Name"      = "anz-tasks-trfm-pubsub1"
  }
}
resource "aws_subnet" "anz-tasks-trfm-subnet2-pub" {
  cidr_block        = var.anz-tasks-trfm-subnet2-cidrblock
  availability_zone = var.anz-tasks-trfm-subnet2-azone
  vpc_id            = aws_vpc.anz-tasks-trfm-vpc.id

  tags = {
    "Name"      = "anz-tasks-trfm-pubsub2"
  }
}

# Configure IGW and associate it with VPC
resource "aws_internet_gateway" "anz-tasks-trfm-igw" {
  vpc_id = aws_vpc.anz-tasks-trfm-vpc.id

  tags = {
    "Name"      = "anz-tasks-trfm-igw"
  }
}

# Configure Route Table and Configure Public Route Entry
resource "aws_route_table" "anz-tasks-trfm-routetable" {
  vpc_id = aws_vpc.anz-tasks-trfm-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.anz-tasks-trfm-igw.id
  }

  tags = {
    "Name"      = "anz-tasks-trfm-routetable"
  }
}

# Configure Subnets in the Route Table - Subnet1
resource "aws_route_table_association" "anz-tasks-trfm-routetable_assoc_subnet1" {
  route_table_id = aws_route_table.anz-tasks-trfm-routetable.id
  subnet_id      = aws_subnet.anz-tasks-trfm-subnet1-pub.id
}

# Configure Subnets in the Route Table - Subnet2
resource "aws_route_table_association" "anz-tasks-trfm-routetable_assoc_subnet2" {
  route_table_id = aws_route_table.anz-tasks-trfm-routetable.id
  subnet_id      = aws_subnet.anz-tasks-trfm-subnet2-pub.id
}