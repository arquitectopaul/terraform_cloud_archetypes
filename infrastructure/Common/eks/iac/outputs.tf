output "load_balancer_controller_iam_role_arn" {
  value = aws_iam_role.load_balancer_controller.arn
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "oidc_provider" {
  value = module.eks.oidc_provider
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_identity_providers" {
  value = module.eks.cluster_identity_providers
}

# output "bastion_public_ip" {
#   value = aws_instance.bastion.public_ip
# }

# output "bastion_public_dns" {
#   value = aws_instance.bastion.public_dns
# }

# output "bastion_private_dns" {
#   value = aws_instance.bastion.private_dns
# }

# output "bastion_private_ip" {
#   value = aws_instance.bastion.private_ip
# }

output "bastion_public_ip" {
  value = module.ec2_instance.public_ip
}

output "bastion_public_dns" {
  value = module.ec2_instance.public_dns
}

output "bastion_private_dns" {
  value = module.ec2_instance.private_dns
}

output "bastion_key_pair_name" {
  value = aws_key_pair.instance_private_key_pair.key_name
}

output "bastion_key_pair_id" {
  value = aws_key_pair.instance_private_key_pair.key_pair_id
}
