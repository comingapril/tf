resource "aws_instance" "apache" {
  ami = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "forall"
  subnet_id = data.aws_subnet.first.id
  user_data = file("apache.sh")
  vpc_security_group_ids = ["sg-03d0b2194da305f89"]
}

