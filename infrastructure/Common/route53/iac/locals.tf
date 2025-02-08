locals {
  name_preffix = "${var.custom_region_code}${var.environment_code}"
  name_suffix  = "${var.compacted_project_name}${var.serial_number}"

  terraform_remote_state_bucket_name = "${local.name_preffix}bucket${local.name_suffix}"

  dynamic_tags = {
    environment = "${var.environment_code}",
    project     = "${var.extended_project_name}"
  }
  default_tags = merge("${var.info_tags}", "${local.dynamic_tags}")
}
