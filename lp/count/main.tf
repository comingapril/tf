resource "local_file" "foo" {
 for_each = var.fileinfo
  filename = each.key
  content = each.value.content
}


