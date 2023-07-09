
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier_vpc_info.vpc_cidr
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.ntier_vpc_info.subnet_names)
  cidr_block = cidrsubnet(var.ntier_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.ntier_vpc_info.subnet__azs[count.index]}"
  vpc_id = aws_vpc.ntier.id  #implicit
  tags = {
    Name = var.ntier_vpc_info.subnet_names[count.index]
  }
  depends_on = [ 
    aws_vpc.ntier
   ]
}

resource "aws_internet_gateway" "ntier_igw" {
  vpc_id = aws_vpc.ntier.id  #implicit
  tags = {
    Name = "ntier_igw"
  }
}































