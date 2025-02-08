resource "aws_api_gateway_rest_api" "testAPI" {
  name = "ue2devapigwdesignpatterns01"
  description = "This is my API for demonstration purposes"
  endpoint_configuration {
  types = ["REGIONAL"]
  }
}

/*module "api-gateway" {
  source      = "clouddrove/api-gateway/aws"
  version     = "1.0.1"
  name        = "ue1devapigwdesignpatterns03"
  environment = "dev"
  label_order = ["name", "environment"]
  enabled     = true

  # Api Gateway Resource
  path_parts = ["mydevresource1", "mydevresource2"]

  # Api Gateway Method
  method_enabled = true
  http_methods   = ["GET", "GET"]

  # Api Gateway Integration
  integration_types        = ["MOCK"]
  integration_http_methods = ["POST"]
  uri                      = [""]
  integration_request_parameters = [{
    "integration.request.header.X-Authorization" = "'static'"
  }, {}]
  request_templates = [{
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }, {}]

  # Api Gateway Method Response
  status_codes        = [200, 200]
  response_models     = [{ "application/json" = "Empty" }, {}]
  response_parameters = [{ "method.response.header.X-Some-Header" = true }, {}]

  # Api Gateway Integration Response
  integration_response_parameters = [{ "method.response.header.X-Some-Header" = "integration.response.header.X-Some-Other-Header" }, {}]
  response_templates = [{
    "application/xml" = <<EOF
  #set($inputRoot = $input.path('$'))
  <?xml version="1.0" encoding="UTF-8"?>
  <message>
      $inputRoot.body
  </message>
  EOF
  }, {}]

  # Api Gateway Deployment
  deployment_enabled = true
  stage_name         = "deploy"

  # Api Gateway Stage
  stage_enabled = true
  stage_names   = ["qa", "dev"]

  depends_on = [
    module.lambda_function
  ]
}
*/
  
/*
resource "aws_api_gateway_authorizer" "authorizer" {
  name                             = "Authorizer"
  rest_api_id                      = module.api-gateway.id
  authorizer_uri                   = module.lambda_function.lambda_function_invoke_arn
  type                             = "TOKEN"
  authorizer_result_ttl_in_seconds = 0
}*/