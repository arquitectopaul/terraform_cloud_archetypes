/*module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.12.1"
  function_name = "lambda_authorizer"
  description   = "Authorization OPA Lambda Function"
  handler       = "handler.opaExecution"
  runtime       = "nodejs16.x"
  memory_size   = "256"
  timeout       = "60"

  source_path = "./opa/lambda_authorizer"

  vpc_subnet_ids         = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_security_group_ids = [var.default_security_group_id]
  attach_network_policy  = true

  environment_variables = {
    #OPA_AGENT_URI            = "k8s-backend-opalb-3b2aece36f-45c996ca4512994e.elb.us-east-2.amazonaws.com"
    OPA_AGENT_URI            = "ue2devlbdesignpatterns01-91ec3a03c95a13b9.elb.us-east-2.amazonaws.com"
    OPA_AGENT_PORT           = "80"
    OPA_AGENT_PATH           = "/v1/data"
    COGNITO_USER_POOL_REGION = "us-east-2"
    COGNITO_USER_POOL_ID     = "us-east-2_xe8jaRtTF"
    #COGNITO_USER_POOL_ID     = "us-east-2_Uvoj5377K"
    COGNITO_TOKEN_EXPIRATION = 300
    INTERNAL_CUSTOMER        = "us-east-2_xe8jaRtTF_AzureAD"
    #INTERNAL_CUSTOMER        = "us-east-2_Uvoj5377K_AzureAD"
    EXTERNAL_CUSTOMER        = "Clientes"
  }

  tags = {
    Name = "lambda_authorizer"
  }
}*/