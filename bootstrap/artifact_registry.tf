resource "google_project_service" "artifact_registry" {
  project = local.project_id
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "railway_containers" {
  project       = local.project_id
  location      = "europe-west1"
  repository_id = "railway-containers"
  description   = "Container images for railway analytics workloads"
  format        = "DOCKER"

  depends_on = [
    google_project_service.artifact_registry,
  ]
}