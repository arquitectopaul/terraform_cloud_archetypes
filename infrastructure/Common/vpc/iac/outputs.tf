output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "intra_subnets" {
  value = module.vpc.intra_subnets
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  value = module.vpc.azs
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "private_route_table_association_ids" {
  value = module.vpc.private_route_table_association_ids
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "public_route_table_association_ids" {
  value = module.vpc.public_route_table_association_ids
}

output "internet_gateway_id" {
  value = module.vpc.igw_id
}

output "nat_ids" {
  value = module.vpc.nat_ids
}

output "nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "nat_public_ips" {
  value = module.vpc.nat_public_ips
}
