resource "aws_instance" "apache" {
  ami = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "forall"
  subnet_id = data.aws_subnet.first.id
  user_data = file("apache.sh")
  vpc_security_group_ids = ["sg-03d0b2194da305f89"]
  connection {
    host = self.public_ip
    user = "ububtu"
    private_key = file("~/.ssh/id_rsa")
    type = "ssh"
  }
  provisioner "file" {
    source = "apache.sh"
    destination = "/tmp/apache.sh"
  }
  provisioner "remote-exec" {
    script = "/tmp/apache.sh"
  }
}

