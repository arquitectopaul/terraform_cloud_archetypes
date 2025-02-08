resource "tls_private_key" "instance_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance_private_key_pair" {
  key_name   = local.key_pair_name
  public_key = tls_private_key.instance_private_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "./generated/${aws_key_pair.instance_private_key_pair.key_name}.pem"
  content  = tls_private_key.instance_private_key.private_key_pem
}

# resource "aws_iam_role" "ec2_bastion_role" {
#   name = "${local.bastion_instance_name}-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "policy_admin_access_attachment" {
#   policy_arn = data.aws_iam_policy.aws_admin_access_policy.arn
#   role       = aws_iam_role.ec2_bastion_role.name
# }

# resource "aws_iam_instance_profile" "ec2_bastion_profile" {
#   name = "${local.bastion_instance_name}-profile"
#   role = aws_iam_role.ec2_bastion_role.name
# }

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.0"

  name = local.bastion_instance_name

  ami                         = var.bastion_instance_ami
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.instance_private_key_pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0)
  # iam_instance_profile        = aws_iam_instance_profile.ec2_bastion_profile.name

  # user_data_base64 = base64encode(local.user_data)
  user_data = file("./scripts/ec2-bastion.sh")
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.security_group_name
  description = "Security group for usage with EC2 instance EKS"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}
