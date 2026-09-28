resource "google_service_account" "railway_ingest_runner" {
  project      = data.google_project.current.project_id
  account_id   = "railway-ingest-runner"
  display_name = "Railway ingestion runner"
}