variable "aws_region" {
  description = "Region de AWS para deploys"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key_id" {
  description = "IAM access key ID. AWS_ACCESS_KEY_ID"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_secret_access_key" {
  description = "IAM secret access key. AWS_SECRET_ACCESS_KEY"
  type        = string
  sensitive   = true
  default     = null
}