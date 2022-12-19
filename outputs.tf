output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = local.password
  sensitive   = true
}
output "db_instance_endpoint" {
  description = "The DNS address of the DocDB Cluster"
  value       = try(aws_docdb_cluster.this[0].endpoint, "")
}

output "db_instance_endpoint_reader" {
  description = "The DNS address of the DocDB Cluster"
  value       = try(aws_docdb_cluster.this[0].reader_endpoint, "")
}
