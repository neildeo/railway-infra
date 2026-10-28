resource "google_service_account" "railway_ingest_runner" {
  project      = data.google_project.current.project_id
  account_id   = "railway-ingest-runner"
  display_name = "Railway ingestion runner"
}

resource "google_service_account_iam_member" "railway_ingestion_ci_runner_act_as" {
  service_account_id = google_service_account.railway_ingest_runner.name

  role   = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}

resource "google_service_account" "cloud_scheduler" {
  project      = data.google_project.current.project_id
  account_id   = "railway-cloud-scheduler"
  display_name = "Railway Cloud Scheduler"
}

resource "google_service_account" "schedule_loader_workflow" {
  project      = data.google_project.current.project_id
  account_id   = "schedule-loader-workflow"
  display_name = "SCHEDULE loader workflow"
}

resource "google_project_iam_member" "schedule_loader_workflow_logs_writer" {
  project = data.google_project.current.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.schedule_loader_workflow.email}"
}