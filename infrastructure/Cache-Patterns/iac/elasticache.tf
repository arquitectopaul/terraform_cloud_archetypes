resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.namespace}-cache-subnet"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
}
