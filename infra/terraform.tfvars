project_name = "petclinic"
environment  = "prod"
aws_region   = "us-east-1"

# Leave domain_name = "" to skip Route53/ACM and expose the app via the
# CloudFront default domain (*.cloudfront.net) instead.
domain_name = "gamela.shop"
subdomain   = "petclinic"

ecr_repository_name = "petclinic"
container_image_tag = "latest"
container_port      = 8080
health_check_path   = "/actuator/health"

task_cpu      = 512
task_memory   = 1024
desired_count = 2

db_name           = "petclinic"
db_username       = "petclinic"
db_engine_version = "16.4"
db_instance_class = "db.t4g.micro"

# GitHub Actions OIDC deploy role (used by .github/workflows/pipeline.yml
# via the AWS_ROLE_ARN secret). Set github_org = "" to skip creating it.
github_org  = "guilene1"
github_repo = "pet-clinic-pipeline"

# An OIDC provider for token.actions.githubusercontent.com already exists in
# this AWS account, so reuse it instead of creating a second one.
create_github_oidc_provider = false
