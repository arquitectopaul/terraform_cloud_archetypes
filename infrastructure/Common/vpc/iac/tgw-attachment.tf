resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway_vpc_attachment" {
  subnet_ids                                      = module.vpc.private_subnets
  transit_gateway_id                              = var.existing_transit_gateway_id
  vpc_id                                          = module.vpc.vpc_id
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = {
    Name = "${local.transit_gateway_attachment_name}"
  }
}
