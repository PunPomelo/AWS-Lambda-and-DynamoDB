resource "aws_api_gateway_rest_api" "UserAPI" {
  name        = "UserAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "UserAPIResource" {
  rest_api_id = aws_api_gateway_rest_api.UserAPI.id
  parent_id   = aws_api_gateway_rest_api.UserAPI.root_resource_id
  path_part   = "user"
}

resource "aws_api_gateway_resource" "GetUserAPIResource" {
  rest_api_id = aws_api_gateway_rest_api.UserAPI.id
  parent_id   = aws_api_gateway_resource.UserAPIResource.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "UserAPIMethodPOST" {
  rest_api_id   = aws_api_gateway_rest_api.UserAPI.id
  resource_id   = aws_api_gateway_resource.UserAPIResource.id
  http_method   = "POST"
  authorization = "NONE"
  # request_models = {
  #   "content-type" = "application/json"
  # }
  request_parameters = {
    "method.request.header.content-type" = true
  }
}

resource "aws_api_gateway_method" "UserAPIMethodGET" {
  rest_api_id   = aws_api_gateway_rest_api.UserAPI.id
  resource_id   = aws_api_gateway_resource.GetUserAPIResource.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.content-type" = true
  }
}

resource "aws_api_gateway_integration" "UserAPIIntMethodPOST" {
  rest_api_id             = aws_api_gateway_rest_api.UserAPI.id
  resource_id             = aws_api_gateway_resource.UserAPIResource.id
  http_method             = aws_api_gateway_method.UserAPIMethodPOST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.putUserDataTF.invoke_arn
}

resource "aws_api_gateway_integration" "UserAPIIntMethodGET" {
  rest_api_id             = aws_api_gateway_rest_api.UserAPI.id
  resource_id             = aws_api_gateway_resource.GetUserAPIResource.id
  http_method             = aws_api_gateway_method.UserAPIMethodGET.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.getUserDataTF.invoke_arn
}

resource "aws_api_gateway_method_response" "UserAPIMethodPOSTResponse" {
  rest_api_id = aws_api_gateway_rest_api.UserAPI.id
  resource_id = aws_api_gateway_resource.UserAPIResource.id
  http_method = aws_api_gateway_method.UserAPIMethodPOST.http_method
  status_code = "200"
}

resource "aws_api_gateway_method_response" "UserAPIMethodGETResponse" {
  rest_api_id = aws_api_gateway_rest_api.UserAPI.id
  resource_id = aws_api_gateway_resource.GetUserAPIResource.id
  http_method = aws_api_gateway_method.UserAPIMethodGET.http_method
  status_code = "200"
}

# resource "aws_api_gateway_model" "UserModel" {
#   rest_api_id  = aws_api_gateway_rest_api.UserAPI.id
#   name         = "usermodel"
#   description  = "a JSON schema"
#   content_type = "application/json"

#   schema = <<EOF
# {
#   "type": "object"
# }
# EOF
# }

