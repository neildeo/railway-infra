resource "google_project_iam_member" "terraform_ci_browser" {
  project = local.project_id
  role    = "roles/browser"
  member  = google_service_account.terraform_ci.member
}