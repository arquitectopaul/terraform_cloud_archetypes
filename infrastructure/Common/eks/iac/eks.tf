module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name                   = local.eks_cluster_name
  cluster_version                = "1.25"
  cluster_endpoint_public_access = false

  cluster_addons = {
    kube-proxy = {}
    vpc-cni    = {}
    coredns = {
      configuration_values = jsonencode({
        computeType = "Fargate"
      })
    }
  }

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids               = data.terraform_remote_state.vpc.outputs.private_subnets
  control_plane_subnet_ids = data.terraform_remote_state.vpc.outputs.intra_subnets

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_cluster_security_group = true
  create_node_security_group    = false

  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  fargate_profiles = merge(
    {
      # "ue1devfargatepfexamensolucion01" = {
      "${local.fargate_profile_name}" = {
        # name = "ue1devfargatepfexamensolucion01"
        name = local.fargate_profile_name
        selectors = [
          {
            namespace = var.kubernetes_namespace
          }
        ]

        # Using specific subnets instead of the subnets supplied for the cluster itself
        subnet_ids = [data.terraform_remote_state.vpc.outputs.private_subnets[1]]

        tags = {
          Owner = "secondary"
        }

        timeouts = {
          create = var.create_timeout
          delete = var.delete_timeout
        }
      }
    },
    { for i in range(length(data.terraform_remote_state.vpc.outputs.availability_zones)) :
      "kube-system-${element(split("-", data.terraform_remote_state.vpc.outputs.availability_zones[i]), 2)}" => {
        selectors = [
          { namespace = "kube-system" }
        ]
        # We want to create a profile per AZ for high availability
        subnet_ids = [element(data.terraform_remote_state.vpc.outputs.private_subnets, i)]
      }
    }
  )
}

resource "aws_security_group_rule" "cluster_security_from_bastion" {
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
  security_group_id = module.eks.cluster_security_group_id
}

resource "aws_iam_policy" "additional" {
  # name = "ue1deviampolicyexamensolucion01"
  name = local.policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# AWS Application Load Balancer Controller IAM Policy and Roles
# curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.3.1/docs/install/iam_policy.json
# curl -o iam_policy_v1_to_v2_additional.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.3.1/docs/install/iam_policy_v1_to_v2_additional.json

resource "aws_iam_policy" "load_balancer_controller" {
  name   = join("-", [local.eks_cluster_name, "nlb-cont"])
  policy = file("./policies/AWSLoadBalancerController.json")
}

resource "aws_iam_role" "load_balancer_controller" {
  name = join("-", [local.eks_cluster_name, "alb-role"])
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""

        Principal = {
          Federated = "${module.eks.oidc_provider_arn}"
        }

        "Condition" = {
          "StringEquals" = {
            "${module.eks.oidc_provider}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller" {
  policy_arn = aws_iam_policy.load_balancer_controller.arn
  role       = aws_iam_role.load_balancer_controller.name
}
