resource "google_cloud_run_v2_job" "dummy" {
  project  = local.project_id
  name     = "dummy-job"
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.cloud_run_dummy.email

      containers {
        image = "europe-west1-docker.pkg.dev/railway-analytics-508615/railway-containers/cloud-run-bootstrap@sha256:2d9ddc91c418e7d47e928c4ffc991979f4efae8e84cf44138941b00b3e2a311f"
      }
    }
  }

  lifecycle {
    # Application CI/CD owns subsequent container image deployments.
    ignore_changes = [
      template[0].template[0].containers[0].image,
    ]
  }
}