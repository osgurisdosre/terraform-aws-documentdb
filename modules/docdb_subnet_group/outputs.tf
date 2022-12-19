output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = try(aws_docdb_subnet_group.this[0].id, "")
}

output "db_subnet_group_arn" {
  description = "ARN"
  value       = try(aws_docdb_subnet_group.this[0].arn, "")
}
