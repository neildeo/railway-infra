resource "google_workflows_workflow" "schedule_loader" {
  project         = data.google_project.current.project_id
  region          = "europe-west1"
  name            = "railway-load-schedule-object"
  description     = "Load all record families from one exact landed SCHEDULE object generation."
  service_account = google_service_account.schedule_loader_workflow.id

  deletion_protection = false

  source_contents = file(
    "${path.module}/workflows/schedule_loader.yaml"
  )
}