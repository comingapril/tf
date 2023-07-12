output "db_endpoint" {
  value = aws_aws_db_instance.empdb.endpoint
}

output "ubuntu_ami_id" {
  value = data.aws_ami_ids.ubuntu_22.04.ids[0]
}