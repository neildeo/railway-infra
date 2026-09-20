resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI"
  description  = "Service account impersonated by GitHub Actions for Terraform CI/CD"
}