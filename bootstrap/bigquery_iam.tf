resource "google_project_iam_member" "terraform_ci_bigquery_metadata_viewer" {
  project = local.project_id
  role    = "roles/bigquery.metadataViewer"
  member  = google_service_account.terraform_ci.member
}