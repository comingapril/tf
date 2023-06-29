variable "region" {
  type = string
  default = "us-west-2"
  description = "Region to create resources"
}

variable "ntier-vpc-range" {
  type = string
  default = "192.168.0.0/16"
  description = "VPC cidr Range"
}

variable "ntier-subnet-azs" {
  type = list(string)
  default = [ "a", "b", "a", "b" ]
}

variable "ntier-subnet-names" {
  type = list(string)
  default = [ "app1", "app2", "db1", "db2" ]
}