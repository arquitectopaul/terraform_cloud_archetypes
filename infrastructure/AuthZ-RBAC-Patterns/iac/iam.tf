resource "aws_iam_role" "lambda_autorizador_rol" {
  name = "lambda_autorizador_rol"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_autorizador_rol.name
  policy_arn = "arn:aws:iam::398356659603:policy/lambda_Rolepolicy"
}

resource "aws_iam_policy" "load_balancer_controller" {
  name        = "AmazonEKSLoadBalancerControllerPolicyTF"
  path        = "/"
  description = "Policy for load balancer controller on EKS"
  policy = file("iam_policy.json")
}

resource "aws_iam_role" "load_balancer_controller" {
  name = "AmazonEKSLoadBalancerControllerRoleTF"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
        "Condition"= {
          "StringEquals"= {
                    "${module.eks.oidc_provider}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

}

resource "aws_iam_policy_attachment" "load_balancer_controller" {
  name       = "AmazonEKSLoadBalancerControllerRoleTF"
  roles      = [aws_iam_role.load_balancer_controller.name]
  policy_arn = aws_iam_policy.load_balancer_controller.arn
}

