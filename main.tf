resource "aws_api_gateway_method" "cors_method" {
  rest_api_id   = var.api
  resource_id   = var.resource
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cors_integration" {
  rest_api_id = var.api
  resource_id = var.resource
  http_method = aws_api_gateway_method.cors_method.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{ "statusCode": 200 }
EOF

  }
}

resource "aws_api_gateway_method_response" "cors_method_response" {
  rest_api_id = var.api
  resource_id = var.resource
  http_method = aws_api_gateway_method.cors_method.http_method

  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "cors_integration_response" {
  rest_api_id = var.api
  resource_id = aws_api_gateway_method.cors_method.resource_id
  http_method = aws_api_gateway_method.cors_method.http_method

  status_code = aws_api_gateway_method_response.cors_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'${local.headers}'"
    "method.response.header.Access-Control-Allow-Methods" = "'${local.methods}'"
    "method.response.header.Access-Control-Allow-Origin" = "'${var.origin}'"
  }
}

