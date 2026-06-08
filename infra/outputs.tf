output "site_url" {
  description = "Public URL for the deployed site."
  value       = "https://${var.site_domain}"
}

output "s3_bucket" {
  description = "S3 bucket holding the static dashboard."
  value       = aws_s3_bucket.site.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID — used for cache invalidations."
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront's own *.cloudfront.net domain (smoke-test before DNS propagates)."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "github_deploy_role_arn" {
  description = "IAM role ARN GitHub Actions assumes via OIDC. Set as repo variable AWS_DEPLOY_ROLE_ARN."
  value       = aws_iam_role.github_deploy.arn
}
