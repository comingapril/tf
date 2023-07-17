resource "local_file" "foo" {
 for_each = var.fileinfo
  filename = each.key.name
  content = each.value.content
}


