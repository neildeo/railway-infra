resource "google_service_account" "cloud_run_dummy" {
  project      = local.project_id
  account_id   = "cloud-run-dummy"
  display_name = "Cloud Run dummy job"
  description  = "Runtime identity for the Cloud Run proof-of-concept job."
}