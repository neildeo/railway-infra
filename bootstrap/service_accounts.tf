resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI"
  description  = "Service account impersonated by GitHub Actions for Terraform CI/CD"
}

resource "google_service_account" "railway_ingestion_ci" {
  project      = "railway-analytics-508615"
  account_id   = "railway-ingestion-ci"
  display_name = "Railway ingestion CI"
}