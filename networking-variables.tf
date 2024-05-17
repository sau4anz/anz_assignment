# VPC
variable "anz-tasks-trfm-vpc-cidrblock" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

#Subnets
variable "anz-tasks-trfm-subnet1-cidrblock" {
  description = "CIDR block for first Subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "anz-tasks-trfm-subnet2-cidrblock" {
  description = "CIDR block for Second Subnet"
  type        = string
  default     = "10.0.2.0/24"
}

#Availabilty Zones
variable "anz-tasks-trfm-subnet1-azone" {
  description = "Availability Zone for First Subnet"
  type        = string
  default     = "us-east-1a"
}
variable "anz-tasks-trfm-subnet2-azone" {
  description = "Availability Zone for Second Subnet"
  type        = string
  default     = "us-east-1b"
}

