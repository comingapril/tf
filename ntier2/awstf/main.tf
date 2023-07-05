
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier_vpc_range
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.ntier_subnet_names)
  cidr_block = cidrsubnet(var.ntier_vpc_range, 8, count.index)
  availability_zone = "${var.region}${var.ntier_subnet_azs[count.index]}"
  vpc_id = aws_vpc.ntier.id  #implicit
  tags = {
    Name = var.ntier_subnet_names[count.index]
  }
  depends_on = [ 
    aws_vpc.ntier
   ]
}

































