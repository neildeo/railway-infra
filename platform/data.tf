data "google_service_account" "railway_ingestion_ci" {
  project    = local.project_id
  account_id = "railway-ingestion-ci"
}