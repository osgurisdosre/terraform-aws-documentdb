output "db_parameter_group_id" {
  description = "The db subnet group name"
  value       = try(aws_docdb_cluster_parameter_group.this[0].id, "")
}

output "db_parameter_group_arn" {
  description = "ARN"
  value       = try(aws_docdb_cluster_parameter_group.this[0].arn, "")
}
