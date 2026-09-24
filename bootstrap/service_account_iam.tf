resource "google_service_account_iam_member" "terraform_ci_wif" {
  service_account_id = google_service_account.terraform_ci.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository_id/${local.github_repository_id}"
}

resource "google_service_account_iam_member" "railway_ingestion_ci_wif" {
  service_account_id = google_service_account.railway_ingestion_ci.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository_id/${local.railway_ingest_repo_id}"
}