locals {
  app_name              = "${var.app_name_prefix}${var.frontend_name}"
  app_bucket_name       = "${var.resource_name_preffix}${var.custom_bucket_resource_code}${var.resource_name_suffix}-${local.app_name}"
  app_distribution_name = "${var.resource_name_preffix}${var.custom_distribution_resource_code}${var.resource_name_suffix}-${local.app_name}"
}
