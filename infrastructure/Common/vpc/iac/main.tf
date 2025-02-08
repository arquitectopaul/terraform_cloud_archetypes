module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.vpc_name
  cidr = var.vpc_cidr

  azs = local.availability_zones_codes

  private_subnets = [for k, v in local.availability_zones_codes : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.availability_zones_codes : cidrsubnet(var.vpc_cidr, 8, k + 48)]

  // Subredes privadas que no deben tener enrutamiento de Internet
  intra_subnets = [for k, v in local.availability_zones_codes : cidrsubnet(var.vpc_cidr, 8, k + 52)]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_route" "additional_private_routes" {

  # TODO: Por que solo se toma un id y no todos
  route_table_id = module.vpc.private_route_table_ids[0]

  transit_gateway_id = var.existing_transit_gateway_id

  for_each               = var.remote_private_routes
  destination_cidr_block = each.value["cidr_blocks"]
}
