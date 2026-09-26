resource "google_project_service" "artifact_registry" {
  project = local.project_id
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "cloud_run" {
  project = local.project_id
  service = "run.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "secret_manager" {
  project = data.google_project.current.project_id
  service = "secretmanager.googleapis.com"

  disable_on_destroy = false
}
