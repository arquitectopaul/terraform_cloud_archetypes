locals {
  name_preffix = "${var.custom_region_code}${var.environment_code}"
  name_suffix  = "${var.compacted_project_name}${var.serial_number}"

  vpc_name                        = "${local.name_preffix}${var.custom_vpc_resource_code}${local.name_suffix}"
  transit_gateway_attachment_name = "${local.name_preffix}${var.custom_transit_gateway_attachment_resource_code}${local.name_suffix}"

  availability_zones_codes = slice(data.aws_availability_zones.available.names, 0, "${var.availability_zones_quantity}")

  dynamic_tags = {
    environment = "${var.environment_code}",
    project     = "${var.extended_project_name}"
  }
  default_tags = merge("${var.info_tags}", "${local.dynamic_tags}")
}
