
resource "aws_vpc" "ntier" {
    cidr_block = var.ntier-vpc-range
    tags = {
        Name = "ntier"
    }
}

resource "aws_subnet" "subnets" {
    count = length(var.ntier-subnet-names)
  cidr_block = cidrsubnet(var.ntier-vpc-range,8,count.index)
  availability_zone = "${var.region}${var.ntier-subnet-azs[count.index]}"
  vpc_id = aws_vpc.ntier.id  #implicit dependency
  depends_on = [ aws_vpc.ntier ]
  tags = {
    Name = var.ntier-subnet-names[count.index]
  }
}

