
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

data "aws_subnets" "public" {
  vpc_id = local.vpc_id
  filter {
    name = "tag:Name"
    values = var.ntier_vpc_info.public_subnets
  }
  depends_on = [ aws_subnet.subnets ]
}

data "aws_subnets" "private" {
  vpc_id = local.vpc_id
  filter {
    name = "tag:Name"
    values = var.ntier_vpc_info.private_subnets
  }
  depends_on = [ aws_subnet.subnets ]
}

resource "aws_route_table_association" "public_associations" {
  count = length(data.aws_subnets.public.ids)
  route_table_id = aws_route_table.public.id
  subnet_id = data.aws_subnets.public.ids[count.index]
}

resource "aws_route_table_association" "private_associations" {
  count = length(data.aws_subnets.private.ids)
  route_table_id = aws_route_table.private.id
  subnet_id = data.aws_subnets.private.ids[count.index]
}


























