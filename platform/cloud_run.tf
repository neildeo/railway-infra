resource "google_cloud_run_v2_job" "railway_ingest_corpus" {
  project  = data.google_project.current.project_id
  name     = "railway-ingest-corpus"
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.railway_ingest_runner.email

      containers {
        image = local.default_cloud_run_job_image

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].template[0].containers[0].image,
    ]
  }
}