/*
#############
# Identity Pool
#############

resource "aws_cognito_identity_pool" "identity_pool" {
  count = 2
  identity_pool_name               = "ue2devidentitypooldesignpatterns0${count.index+1}"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = "4akgl7mcf30i5m3ne3gg6l4ls"
    provider_name           = "cognito-idp.us-east-2.amazonaws.com/us-east-2_Uvoj5377K"
    server_side_token_check = false
  }
}

resource "aws_iam_role" "lambda_autorizer0_rol" {
  name = "lambda_autorizer0_rol"

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
  role       = aws_iam_role.lambda_autorizer0_rol.name
  policy_arn = "arn:aws:iam::398356659603:policy/lambda_Rolepolicy"
}
*/

