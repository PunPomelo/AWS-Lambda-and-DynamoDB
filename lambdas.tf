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
