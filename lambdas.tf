resource "aws_iam_role_policy" "dynamo_rw_access" {
  name = "DynamoReadWriteAccess"
  role = aws_iam_role.lambda_exec.id

  # TODO: try to use resource from dynamodb.tf 
  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem"
            ],
            "Resource": "arn:aws:dynamodb:us-west-1:659043227432:table/Users"
        }
    ]
}
  EOF
}

resource "aws_iam_role" "lambda_exec" {
  name               = "LambdaDynamoDBRoleTF"
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

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# resource "null_resource" "create_auth_npm_install" {
#   triggers = {
#     build_number = timestamp()
#   }
#   depends_on = [template_dir.lambda_template]
#   provisioner "local-exec" {
#     command = "cd lambda-triggers/02-create-auth-challenge && npm install $(npm pack ../../utils | tail -1) && rm utils*"
#   }
# }
data "archive_file" "create_auth_challenge_zip" {
  type        = "zip"
  source_file = "${path.module}/getUserData/index.js"
  output_path = "${path.module}/getUserData.zip"
  # depends_on  = [null_resource.create_auth_npm_install]
}
# resource "aws_lambda_function" "create_auth_challenge" {
#   function_name = "${var.environment_name}-create-auth-challenge"
#   publish       = true
#   role          = data.aws_iam_role.lambda_base.arn
#   runtime       = "nodejs12.x"
#   filename      = data.archive_file.create_auth_challenge_zip.output_path
#   handler       = "create-auth-challenge.handler"
#   timeout       = 30
#   memory_size   = 128
#   vpc_config {
#     security_group_ids = [aws_security_group.lambda.id]
#     subnet_ids         = data.aws_subnet_ids.topup.ids
#   }
#   source_code_hash = data.archive_file.create_auth_challenge_zip.output_base64sha256
#   depends_on = [aws_cloudwatch_log_group.topup_lambda_log_groups_create_auth_challenge]
#   tags = {
#     Team        = "Autobot"
#     Name        = "Topup Create auth challenge Lambda"
#     App         = "Topup"
#     Component   = "Lambda"
#     Environment = var.environment_name
#   }
# }
