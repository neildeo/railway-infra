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

resource "google_artifact_registry_repository_iam_member" "terraform_ci_reader" {
  project    = local.project_id
  location   = google_artifact_registry_repository.railway_containers.location
  repository = google_artifact_registry_repository.railway_containers.repository_id

  role   = "roles/artifactregistry.reader"
  member = google_service_account.terraform_ci.member
}

resource "google_artifact_registry_repository_iam_member" "railway_ingestion_ci_writer" {
  project    = google_artifact_registry_repository.railway_containers.project
  location   = google_artifact_registry_repository.railway_containers.location
  repository = google_artifact_registry_repository.railway_containers.name

  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.railway_ingestion_ci.email}"
}