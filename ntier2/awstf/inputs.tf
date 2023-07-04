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

variable "ntier_app1_cidr" {
  type = string
  default = "192.168.0.0/24"
}

variable "ntier_app2_cidr" {
  type = string
  default = "192.168.1.0/24"
}


variable "ntier_db1_cidr" {
  type = string
  default = "192.168.2.0/24"
}

variable "ntier_db2_cidr" {
  type = string
  default = "192.168.3.0/24"
}

