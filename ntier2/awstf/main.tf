
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier_vpc_range
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "app1" {
  cidr_block = var.ntier_app1_cidr
  availability_zone = "{var.region}a"
  vpc_id = aws_vpc.ntier.id
  depends_on = [ 
    aws_vpc.ntier
   ]
}

resource "aws_subnet" "app2" {
  cidr_block = var.ntier_app2_cidr
  availability_zone = "{var.region}b"
  vpc_id = aws_vpc.ntier.id
  depends_on = [ 
    aws_vpc.ntier
   ]
}

resource "aws_subnet" "db1" {
  cidr_block = var.ntier_db1_cidr
  availability_zone = "{var.region}a"
  vpc_id = aws_vpc.ntier.id
  depends_on = [ 
    aws_vpc.ntier
   ]
}

resource "aws_subnet" "db2" {
  cidr_block = var.ntier_db2_cidr
  availability_zone = "{var.region}b"
  vpc_id = aws_vpc.ntier.id
  depends_on = [ 
    aws_vpc.ntier
   ]
}