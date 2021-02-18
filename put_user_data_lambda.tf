resource "aws_lambda_function" "putUserDataTF" {
  function_name = "putUserData"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "get-user-data-tf"
  s3_key    = "v1.0.0/putUserData.zip"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "index.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "putUserData"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.UserAPI.execution_arn}/*/*/*"
}
