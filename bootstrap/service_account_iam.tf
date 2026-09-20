resource "google_service_account_iam_member" "terraform_ci_wif" {
  service_account_id = google_service_account.terraform_ci.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/github-actions/attribute.repository_id/${local.github_repository_id}"
}