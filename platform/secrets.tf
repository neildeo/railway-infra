resource "google_secret_manager_secret" "network_rail_credentials" {
  project   = data.google_project.current.project_id
  secret_id = "network-rail-credentials"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "railway_ingest_runner_secret_accessor" {
  project   = google_secret_manager_secret.network_rail_credentials.project
  secret_id = google_secret_manager_secret.network_rail_credentials.secret_id

  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.railway_ingest_runner.email}"
}