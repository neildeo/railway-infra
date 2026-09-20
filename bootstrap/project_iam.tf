resource "google_project_iam_member" "terraform_ci_plan" {
  project = local.project_id
  role    = google_project_iam_custom_role.terraform_plan.name
  member  = google_service_account.terraform_ci.member
}