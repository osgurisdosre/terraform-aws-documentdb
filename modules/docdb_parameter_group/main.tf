resource "aws_docdb_cluster_parameter_group" "this" {
  count       = var.create ? 1 : 0
  family      = var.family
  name        = var.name
  description = var.description
  tags        = var.tags

  dynamic "parameter" {
    for_each = var.parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}
