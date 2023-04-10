locals {
  db_subnet_group_name    = var.create_db_subnet_group ? module.docdb_subnet_group.db_subnet_group_id : var.db_subnet_group_name
  db_parameter_group_name = var.create_db_parameter_group ? module.docdb_parameter_group.db_parameter_group_id : var.db_parameter_group_name
  password                = var.create_db_password ? random_password.master_password[0].result : var.password
}

resource "random_password" "master_password" {
  count = var.create_db_password ? 1 : 0

  length  = var.random_password_length
  special = false

  lifecycle {
    ignore_changes = all
  }
}

module "docdb_subnet_group" {
  source = "./modules/docdb_subnet_group"

  create = var.create_db_subnet_group

  name        = var.cluster_identifier
  subnet_ids  = var.subnet_ids
  description = var.subnet_description
  name_prefix = var.sg_name_prefix
  tags        = var.tags
}

module "docdb_parameter_group" {
  source = "./modules/docdb_parameter_group"

  create = var.create_db_parameter_group

  name        = var.cluster_identifier
  family      = var.family
  description = "${var.parameter_description} ${var.cluster_identifier}"
  parameters  = var.parameters
  tags        = var.tags
}

resource "aws_docdb_cluster" "this" {
  count                           = var.create_db ? 1 : 0
  cluster_identifier              = var.cluster_identifier
  availability_zones              = var.availability_zones
  master_username                 = var.master_username
  master_password                 = local.password
  db_subnet_group_name            = local.db_subnet_group_name
  db_cluster_parameter_group_name = local.db_parameter_group_name
  engine                          = var.engine
  engine_version                  = var.engine_version
  port                            = var.port
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = var.vpc_security_group_ids
  preferred_backup_window         = var.preferred_backup_window
  backup_retention_period         = var.backup_retention_period
  preferred_maintenance_window    = var.preferred_maintenance_window
  snapshot_identifier             = var.snapshot_identifier
  kms_key_id                      = var.kms_key_id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  final_snapshot_identifier       = var.final_snapshot_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  tags = merge(
    var.tags,
    {
      "Engine" = var.engine
    }
  )
}

resource "aws_docdb_cluster_instance" "this" {
  count                           = var.create_db ? var.cluster_size : 0
  identifier                      = "${var.cluster_identifier}-${count.index}"
  cluster_identifier              = aws_docdb_cluster.this[0].id
  instance_class                  = var.instance_class
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  enable_performance_insights     = var.enable_performance_insights
  engine                          = var.engine
  identifier_prefix               = var.identifier_prefix
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  preferred_maintenance_window    = var.preferred_maintenance_window
  promotion_tier                  = var.promotion_tier
  apply_immediately               = var.apply_immediately
  tags = merge(
    var.tags,
    {
      "Engine" = var.engine
    }
  )
}
