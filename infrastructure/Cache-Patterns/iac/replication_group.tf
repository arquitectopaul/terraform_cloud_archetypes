resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = var.cluster_id
  replication_group_description = var.replicationgroup
  node_type                     = var.nodetype
  port                          = var.redis_port
  parameter_group_name          = var.groupname
  snapshot_retention_limit      = var.snapshot_retention_limit
  snapshot_window               = var.snapshot
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  #availability_zones            = data.terraform_remote_state.vpc.outputs.availability_zones
  automatic_failover_enabled = true
  apply_immediately          = true
  auto_minor_version_upgrade = true
  transit_encryption_enabled = true
  tags                       = local.tags

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = var.node_groups
  }
}
