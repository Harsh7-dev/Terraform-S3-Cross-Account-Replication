variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "source_bucket_name" {
  description = "The name of the source bucket"
  type        = string
  default     = ""
}

variable "replication_role_name" {
  description = "The name of the replication role"
  type        = string
  default     = ""
}


variable "destination_bucket_name" {
  description = "The name of the destination S3 bucket"
  type        = string
  default     = ""
}

variable "iam_replication_policy_name" {
  description = "The name of the IAM replication policy"
  type        = string
  default     = ""
}





