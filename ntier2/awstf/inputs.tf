variable "region" {
  type = string
  default = "us-west-2"
  description = "Region to create resources"
}

variable "ntier_vpc_range" {
  type = string
  default = "192.168.0.0/16"
  description = "VPC cidr range"
}

