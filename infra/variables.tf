variable "aws_region" {
  description = "Primary AWS region for the S3 bucket and IAM resources. CloudFront and ACM are forced to us-east-1 regardless."
  type        = string
  default     = "eu-central-1"
}

variable "site_domain" {
  description = "Fully-qualified domain the site is served on."
  type        = string
  default     = "insieme.kalenskyy.com"
}

variable "parent_zone_name" {
  description = "Route53 hosted-zone name (without trailing dot) that owns site_domain."
  type        = string
  default     = "kalenskyy.com"
}

variable "github_repository" {
  description = "GitHub repository allowed to assume the deploy role, in `owner/name` form."
  type        = string
  default     = "okalenskyy/insieme_tmp"
}

variable "github_branch" {
  description = "Git ref that may assume the deploy role. The OIDC trust policy is scoped to this branch only."
  type        = string
  default     = "main"
}

variable "project" {
  description = "Short kebab-case identifier used as a tag value and in resource names."
  type        = string
  default     = "insieme-dashboard"
}
