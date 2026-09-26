data "google_project" "current" {
  project_id = local.project_id
}

data "google_service_account" "railway_ingestion_ci" {
  project    = local.project_id
  account_id = "railway-ingestion-ci"
}