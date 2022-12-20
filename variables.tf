variable "create" {
  type        = bool
  default     = true
  description = "Create the resource?"
}

variable "cluster_size" {
  type        = number
  default     = 3
  description = "Number of instances."
}

variable "instance_class" {
  type        = string
  description = "The instance class to use."
  default     = null
}

variable "create_db_subnet_group" {
  type        = bool
  default     = false
  description = "Create the resource?"
}
variable "create_db" {
  type        = bool
  default     = true
  description = "Create the resource?"
}
variable "password" {
  description = "Password for the master DB user."
  type        = string
  default     = null
}

variable "create_db_parameter_group" {
  type        = bool
  default     = false
  description = "Create the resource?"
}

variable "create_db_password" {
  type        = bool
  default     = false
  description = "Create the resource?"
}
variable "random_password_length" {
  type        = number
  default     = 16
  description = "The length of the string desired."
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "The DB subnet group to associate with this DB instance."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC subnet IDs."
}

variable "db_parameter_group_name" {
  type        = string
  default     = ""
  description = "A cluster parameter group name."
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = " Specifies whether any database modifications are applied immediately, or during the next maintenance window. "
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in."
}


variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "The days to retain backups for."
}

variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
}

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = null
  description = " A cluster parameter group to associate with the cluster."
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "A value that indicates whether the DB cluster has deletion protection enabled."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["audit", "profiler"]
  description = "List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler."
}

variable "engine_version" {
  type        = string
  description = "The database engine version. Updating this argument results in an outage."
}

variable "engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster."
}

variable "master_password" {
  type        = string
  default     = null
  sensitive   = true
  description = "Password for the master DB user."
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user."
}

variable "preferred_backup_window" {
  type        = string
  default     = "03:00-05:00"
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter."
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sat:05:00-sat:08:00"
  description = "The weekly time range during which system maintenance can occur, in (UTC)."
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the DB cluster is encrypted."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster."
}

variable "port" {
  type        = number
  default     = 27017
  description = "The port on which the DB accepts connections."
}

variable "final_snapshot_identifier" {
  type        = string
  default     = null
  description = "The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made."
}

variable "snapshot_identifier" {
  type        = string
  default     = null
  description = "Specifies whether or not to create this cluster from a snapshot."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS encryption key."
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = false
  description = "This parameter does not apply to Amazon DocumentDB.Amazon DocumentDB does not perform minor version upgrades regardless of the value set."
}

variable "enable_performance_insights" {
  type        = bool
  default     = true
  description = "A value that indicates whether to enable Performance Insights for the DB Instance."
}

variable "identifier_prefix" {
  type        = string
  default     = null
  description = "Creates a unique identifier beginning with the specified prefix."
}
variable "promotion_tier" {
  type        = number
  default     = 0
  description = "Failover Priority setting on instance level. "
}
variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key."
}

variable "family" {
  type        = string
  default     = "docdb4.0"
  description = "The family of the documentDB cluster parameter group."
}
variable "sg_name_prefix" {
  type        = string
  default     = null
  description = "Creates a unique name beginning with the specified prefix."
}

variable "subnet_description" {
  type        = string
  default     = null
  description = "Allowed subnets for DB cluster instances."
}

variable "parameter_description" {
  type        = string
  default     = "Parameter group for"
  description = "Description for the parameter group."
}

variable "parameters" {
  type        = list(map(string))
  default     = []
  description = "List of DB parameters to apply."
}
