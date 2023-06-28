
resource "aws_vpc" "ntier" {
    cidr_block = var.ntier-vpc-range
    tags = {
        Name = "ntier"
    }
}

resource "aws_subnet" "subnets" {
    count = 4
  cidr_block = var.ntier-subnet-cidrs[count.index]
  availability_zone = "${var.region}a"
  vpc_id = aws_vpc.ntier.id  #implicit dependency
  tags = {
        Name = "app1"
    }
  depends_on = [ aws_vpc.ntier ]
}

