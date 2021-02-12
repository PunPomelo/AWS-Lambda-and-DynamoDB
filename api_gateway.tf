resource "aws_api_gateway_rest_api" "UserAPI" {
  name        = "UserAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "UserAPIResource" {
  rest_api_id = aws_api_gateway_rest_api.UserAPI.id
  parent_id   = aws_api_gateway_rest_api.UserAPI.root_resource_id
  path_part   = "user"
}

resource "aws_api_gateway_method" "UserAPIMethod" {
  rest_api_id   = aws_api_gateway_rest_api.UserAPI.id
  resource_id   = aws_api_gateway_resource.UserAPIResource.id
  http_method   = "POST"
  authorization = "NONE"
}
