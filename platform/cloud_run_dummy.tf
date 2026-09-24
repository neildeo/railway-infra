resource "google_service_account" "railway_ingest_dummy_runtime" {
  project      = "railway-analytics-508615"
  account_id   = "railway-ingest-dummy-runtime"
  display_name = "Railway ingest dummy runtime"
}

resource "google_cloud_run_v2_job" "railway_ingest_dummy" {
  project  = "railway-analytics-508615"
  name     = "railway-ingest-dummy-job"
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.railway_ingest_dummy_runtime.email

      containers {
        image = "europe-west1-docker.pkg.dev/railway-analytics-508615/railway-containers/cloud-run-bootstrap@sha256:2d9ddc91c418e7d47e928c4ffc991979f4efae8e84cf44138941b00b3e2a311f"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].template[0].containers[0].image
    ]
  }
}

resource "google_cloud_run_v2_job_iam_member" "railway_ingestion_ci_dummy_developer" {
  project  = google_cloud_run_v2_job.railway_ingest_dummy.project
  location = google_cloud_run_v2_job.railway_ingest_dummy.location
  name     = google_cloud_run_v2_job.railway_ingest_dummy.name

  role   = "roles/run.developer"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}

resource "google_service_account_iam_member" "railway_ingestion_ci_dummy_act_as" {
  service_account_id = google_service_account.railway_ingest_dummy_runtime.name

  role   = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}