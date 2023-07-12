resource "aws_security_group" "web" {
   name = "mysql"
  ingress {
 from_port = local.ssh_port
 to_port = local.ssh_port
 cidr_blocks = [ local.anywhere ]
 protocol = local.tcp
  }
  ingress {
 from_port = local.http_port
 to_port = local.http_port
 cidr_blocks = [ local.anywhere ]
 protocol = local.tcp
  }
  tags = {
    Name = "web"
  }
  vpc_id = local.vpc_id
  depends_on = [ aws_subnet.subnets ]
}

data "aws_ami_ids" "ubuntu_22.04" {
  owners = [ "099720109477" ]
  filter {
    name  = "description"
    values = [ "Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16" ]
  }
  filter {
    name = "is-public"
    values = ["true"]
  }
}