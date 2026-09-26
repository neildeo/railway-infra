resource "google_secret_manager_secret" "network_rail_credentials" {
  project   = data.google_project.current.project_id
  secret_id = "network-rail-credentials"

  replication {
    auto {}
  }
}