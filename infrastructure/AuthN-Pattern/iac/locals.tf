locals {
  resource_name_preffix = "${var.custom_region_code}${var.environment_code}"
  resource_name_suffix  = "${var.compacted_project_name}${var.serial_number}"

  terraform_remote_state_bucket_name = "${local.resource_name_preffix}bucket${local.resource_name_suffix}"

  main_app_bucket_name       = "${local.resource_name_preffix}${var.custom_bucket_resource_code}${local.resource_name_suffix}_${var.main_frontend_name}"
  main_app_distribution_name = "${local.resource_name_preffix}${var.custom_distribution_resource_code}${local.resource_name_suffix}_${var.main_frontend_name}"
  origin_access_name         = "${local.resource_name_preffix}${var.custom_origin_access_resource_code}${local.resource_name_suffix}"
  user_pool_name             = "${local.resource_name_preffix}${var.custom_cognito_user_pool_resource_code}${local.resource_name_suffix}"

  dynamic_tags = {
    environment = var.environment_code,
    project     = var.extended_project_name
  }
  default_tags = merge("${var.info_tags}", "${local.dynamic_tags}")
}
