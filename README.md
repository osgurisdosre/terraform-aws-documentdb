# AWS DocumentDB Terraform module

Terraform module which creates DocumentDB resources on AWS

Root module calls these modules which can also be used separately to create independent resources:

- [db_subnet_group](https://github.com/osgurisdosre/terraform-aws-documentdb/tree/main/modules/docdb_subnet_group) - creates DocumentDB subnet group
- [db_parameter_group](https://github.com/osgurisdosre/terraform-aws-documentdb/tree/main/modules/docdb_parameter_group) - creates DocumentDB parameter group

## Usage

```hcl
module "docdb" {
  source                    = "osgurisdosre/documentdb/aws"

  cluster_identifier        = "demodb"

  engine                 = "docdb"
  engine_version         = "4.0.0"
  cluster_size = 3
  instance_class = "db.t3.medium"
  
  # Credentials
  master_username           = "user"
  create_db_password        = true

  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_security_group_ids = ["sg-12345678"]

  # DB subnet group
  create_db_subnet_group    = true
  subnet_ids = ["subnet-123456789", "subnet-987654321" "subnet-123321123"] 

  # Database Deletion Protection
  deletion_protection = true

  # DB parameter group
  create_db_parameter_group = true
  parameters = [{
    name  = "tls"
    value = "enabled"
  }]

}
```

## Conditional creation

```hcl
module "docdb" {
  source                    = "osgurisdosre/documentdb/aws"
  
  # Disable creation of DocumentDB instance(s)
  create_db                 = false

  # Enable creation of a random password
  create_db_password        = true

  # Enable creation of subnet group
  create_db_subnet_group    = true
  
  # Enable creation of parameter group
  create_db_parameter_group = true

}
```

### Parameter Groups

[Reference](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_groups.html)

Users have the ability to:

- Create a new parameter group (use cluster identifier as name):

```hcl
  create_db_parameter_group = true
  parameters = [{
    name  = "tls"
    value = "enabled"
  }]
```

- Pass the name of a parameter group to use that has been created outside of the module:

```hcl
  create_db_parameter_group = false
  db_parameter_group_name   = "custom-docdb-4.0" # must already exist in AWS
```

- Use a default parameter group provided by AWS

```hcl
  create_db_parameter_group = false
```

## Examples

To-do:

## Notes

1. This module does not create DocumentDB security group. Use [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) module for this.
2. By default, the variable `create_db_password` is set to true. Therefore, even if the user provides a password, it will not be read. The `create_db_password` variable should be set to false and the `password` variable should have a non-null value to be read and used.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_docdb_parameter_group"></a> [docdb\_parameter\_group](#module\_docdb\_parameter\_group) | ./modules/docdb_parameter_group | n/a |
| <a name="module_docdb_subnet_group"></a> [docdb\_subnet\_group](#module\_docdb\_subnet\_group) | ./modules/docdb_subnet_group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | This parameter does not apply to Amazon DocumentDB.Amazon DocumentDB does not perform minor version upgrades regardless of the value set. | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of EC2 Availability Zones that instances in the DB cluster can be created in. | `list(string)` | n/a | yes |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. | `number` | `7` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | The cluster identifier. If omitted, Terraform will assign a random, unique identifier. | `string` | n/a | yes |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of instances. | `number` | `3` | no |
| <a name="input_create"></a> [create](#input\_create) | Create the resource? | `bool` | `true` | no |
| <a name="input_create_db"></a> [create\_db](#input\_create\_db) | Create the resource? | `bool` | `true` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | Create the resource? | `bool` | `false` | no |
| <a name="input_create_db_password"></a> [create\_db\_password](#input\_create\_db\_password) | Create the resource? | `bool` | `false` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Create the resource? | `bool` | `false` | no |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | A cluster parameter group to associate with the cluster. | `string` | `null` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | A cluster parameter group name. | `string` | `""` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The DB subnet group to associate with this DB instance. | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | A value that indicates whether the DB cluster has deletion protection enabled. | `bool` | `false` | no |
| <a name="input_enable_performance_insights"></a> [enable\_performance\_insights](#input\_enable\_performance\_insights) | A value that indicates whether to enable Performance Insights for the DB Instance. | `bool` | `true` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler. | `list(string)` | <pre>[<br>  "audit",<br>  "profiler"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. | `string` | `"docdb"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The database engine version. Updating this argument results in an outage. | `string` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | The family of the documentDB cluster parameter group. | `string` | `"docdb4.0"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made. | `string` | `null` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | Creates a unique identifier beginning with the specified prefix. | `string` | `null` | no |
| <a name="input_instance_azs"></a> [instance\_azs](#input\_instance\_azs) | n/a | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class to use. | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. | `string` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Password for the master DB user. | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user. | `string` | n/a | yes |
| <a name="input_parameter_description"></a> [parameter\_description](#input\_parameter\_description) | Description for the parameter group. | `string` | `"Parameter group for"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | List of DB parameters to apply. | `list(map(string))` | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. | `string` | `null` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections. | `number` | `27017` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. | `string` | `"03:00-05:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | The weekly time range during which system maintenance can occur, in (UTC). | `string` | `"sat:05:00-sat:08:00"` | no |
| <a name="input_promotion_tier"></a> [promotion\_tier](#input\_promotion\_tier) | Failover Priority setting on instance level. | `number` | `0` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | The length of the string desired. | `number` | `16` | no |
| <a name="input_sg_name_prefix"></a> [sg\_name\_prefix](#input\_sg\_name\_prefix) | Creates a unique name beginning with the specified prefix. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted. | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. | `bool` | `true` | no |
| <a name="input_subnet_description"></a> [subnet\_description](#input\_subnet\_description) | Allowed subnets for DB cluster instances. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate with the Cluster. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The DNS address of the DocDB Cluster |
| <a name="output_db_instance_endpoint_reader"></a> [db\_instance\_endpoint\_reader](#output\_db\_instance\_endpoint\_reader) | The DNS address of the DocDB Cluster |
| <a name="output_db_instance_password"></a> [db\_instance\_password](#output\_db\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
