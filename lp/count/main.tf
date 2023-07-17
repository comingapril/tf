resource "local_file" "foo" {
  content  = length(var.filenames)
  filename = var.filenames[count.index]
}