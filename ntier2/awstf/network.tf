
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
  vpc_id = local.vpc_id
  tags = {
    Name = var.ntier_vpc_info.subnet_names[count.index]
  }
  depends_on = [ 
    aws_vpc.ntier
   ]
}

resource "aws_internet_gateway" "ntier_igw" {
  vpc_id = local.vpc_id 
  tags = {
    Name = "ntier_igw"
  }
 depends_on = [ 
    aws_vpc.ntier
   ] 
}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id
  tags = {
    Name = "private"
  }
  depends_on = [ aws_subnet.subnets ]
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  tags = {
    Name = "public"
  }
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.ntier_igw
  }
  depends_on = [ aws_subnet.subnets ]
}





























