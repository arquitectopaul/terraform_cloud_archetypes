/*###variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}*/

variable "cidr_blocks" {
  description = "The CIDR blocks to create the workstations in."
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "namespace" {
  description = "Default namespace"
  default     = "elasticache"
}

variable "cluster_id" {
  description = "Id to assign the new cluster. The ID for the replication group."
  default     = "ue2devecredisdesignpatterns01"
}

variable "replicationgroup" {
  default = "ElastiCache Redis Pattern"
}

variable "node_groups" {
  description = "Number of nodes groups to create in the cluster"
  default     = 3
}

variable "nodetype" {
  default = "cache.t3.micro"
}

variable "groupname" {
  default = "default.redis7.cluster.on"
}

variable "redis_port" {
  description = "The port the elasticache redis instance should run on."
  type        = number
  default     = 6379
}

variable "snapshot" {
  default = "00:00-05:00"
}

variable "snapshot_retention_limit" {
  default = 5
}

variable "auth_token" {
  description = "The authorization token used to access the elasticache redis instance."
  default     = ""
}

variable "engine_version" {
  description = "The version of redis to use."
  default     = "7.0.7"
}
