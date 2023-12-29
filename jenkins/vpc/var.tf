
variable "name" {}
variable "vpc_cidr" {}
# VPC Availability Zones
variable "azs" {}
# VPC Public Subnets
variable "public_subnets" {}
# VPC Private Subnets
variable "private_subnets" {}
# VPC Enable NAT Gateway (True or False) 
variable "enable_nat_gateway" {}
# VPC Single NAT Gateway (True or False)
variable "single_nat_gateway" {}
