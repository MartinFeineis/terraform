resource "aws_lambda_function" "golambda" {
    filename = lambdago.zip
}
