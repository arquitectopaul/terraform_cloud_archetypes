locals {
  name_preffix = "${var.custom_region_code}${var.environment_code}"
  name_suffix  = "${var.compacted_project_name}${var.serial_number}"

  terraform_remote_state_bucket_name = "${local.name_preffix}bucket${local.name_suffix}"

  bastion_instance_name = "${local.name_preffix}${var.custom_ec2_instance_resource_code}${local.name_suffix}"
  key_pair_name         = "${local.name_preffix}${var.custom_key_pair_resource_code}${local.name_suffix}"
  security_group_name   = "${local.name_preffix}${var.custom_security_group_resource_code}${local.name_suffix}"
  policy_name           = "${local.name_preffix}${var.custom_policy_resource_code}${local.name_suffix}"
  eks_cluster_name      = "${local.name_preffix}${var.custom_eks_cluster_resource_code}${local.name_suffix}"
  fargate_profile_name  = "${local.name_preffix}${var.custom_fargate_profile_resource_code}${local.name_suffix}"

  dynamic_tags = {
    environment = var.environment_code,
    project     = var.extended_project_name
  }

  default_tags = merge("${var.info_tags}", "${local.dynamic_tags}")
}
