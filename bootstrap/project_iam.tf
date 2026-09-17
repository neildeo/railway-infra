resource "google_project_iam_member" "terraform_ci_browser" {
  project = "railway-analytics-508615"
  role    = "roles/browser"
  member  = google_service_account.terraform_ci.member
}