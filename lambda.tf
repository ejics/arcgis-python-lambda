################################
# Lambda
################################
data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "build/layer"
  output_path = "lambda/layer.zip"
}
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "build/function"
  output_path = "lambda/function.zip"
}

# Layer
resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name       = "arcgis-python-api-sample-layer"
  filename         = data.archive_file.layer_zip.output_path
  source_code_hash = data.archive_file.layer_zip.output_base64sha256
}

# Function
resource "aws_lambda_function" "arcgis_sample" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = data.archive_file.function_zip.output_path
  function_name = "arcgis-python-api-sample"
  role          = aws_iam_role.lambda_role.arn
  handler       = "src/arcgis-sample.lambda_handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = data.archive_file.function_zip.output_base64sha256
  timeout          = 600

  environment {
    variables = {
      AWS_DEFAULT_REGIONS = var.region
    }
  }
  runtime = "python3.12"
  layers  = ["${aws_lambda_layer_version.lambda_layer.arn}"]
  
  #dead_letter_config {
    #target_arn = "<ARN for SQS queue or SNS topic>"
    #retry_limit = 0
  #}  
}

################################
# LambdaにアタッチするIAM Role
################################
resource "aws_iam_role" "lambda_role" {
  name               = "arcgis-sample-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
