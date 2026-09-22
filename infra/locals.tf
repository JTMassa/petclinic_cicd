locals {
  # Custom domain / Route53 / ACM are only wired up when domain_name is set.
  # With domain_name = "" the app is reachable at the CloudFront default
  # domain (*.cloudfront.net) instead.
  use_custom_domain = var.domain_name != ""
  fqdn              = local.use_custom_domain ? "${var.subdomain}.${var.domain_name}" : null

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    },
    var.tags
  )

  # The GitHub Actions deploy role is only created once we know which repo
  # is allowed to assume it.
  create_github_deploy_role = var.github_org != ""

  # GitHub now embeds immutable org/repo IDs into the OIDC "sub" claim, e.g.
  # "repo:guilene1@203352549/pet-clinic-pipeline@1382023369:ref:refs/heads/main"
  # instead of the plain "repo:guilene1/pet-clinic-pipeline:ref:...". Wildcard
  # the "@<id>" segments so the trust policy still matches on org/repo name.
  github_oidc_subjects = length(var.github_oidc_subjects) > 0 ? var.github_oidc_subjects : [
    "repo:${var.github_org}@*/${var.github_repo}@*:*"
  ]
}
