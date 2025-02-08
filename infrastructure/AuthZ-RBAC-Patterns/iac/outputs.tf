output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.helloworld-lambda
}

output "lambda_function" {
  value = aws_lambda_function.test_lambda
}

output "iam_role" {
  value = aws_iam_role.load_balancer_controller
}

output "iam_policy_log" {
  value = aws_iam_policy.load_balancer_controller
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}

/*output "api_gateway_endpoint" {
  value = data.aws_apigatewayv2_api.lambda.api_endpoint
}*/

/*output "api_invoke_url" {
 value = "${aws_api_gateway_stage.teststage.invoke_url}/${aws_api_gateway_resource.testresource.path_part}"
}*/

output "load_balancer_controller_iam_role_arn"{
  value = aws_iam_role.load_balancer_controller.arn
}

output "cluster_id"{
  value = module.eks.cluster_id
}

output "kubeconfig_command" {
  value = "rm $HOME/.kube/config ; aws eks update-kubeconfig --name ue2deveksdesignpatterns01"
}