resource "google_project_iam_member" "terraform_ci_plan" {
  project = local.project_id
  role    = google_project_iam_custom_role.terraform_plan.name
  member  = google_service_account.terraform_ci.member
}


resource "google_project_iam_member" "railway_ingestion_ci_cloud_run_operations_reader" {
  project = local.project_id
  role    = google_project_iam_custom_role.cloud_run_operations_reader.name
  member  = google_service_account.railway_ingestion_ci.member
}
