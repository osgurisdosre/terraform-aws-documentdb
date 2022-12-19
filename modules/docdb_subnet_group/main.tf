resource "aws_docdb_subnet_group" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  subnet_ids  = var.subnet_ids
  description = var.description
}
