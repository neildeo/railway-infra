resource "google_cloud_run_v2_job" "railway_ingest_corpus" {
  project  = data.google_project.current.project_id
  name     = "railway-ingest-corpus"
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.railway_ingest_runner.email

      max_retries = 0

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

resource "google_cloud_run_v2_job_iam_member" "railway_ingestion_ci_corpus_developer" {
  project  = google_cloud_run_v2_job.railway_ingest_corpus.project
  location = google_cloud_run_v2_job.railway_ingest_corpus.location
  name     = google_cloud_run_v2_job.railway_ingest_corpus.name

  role   = "roles/run.developer"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}

resource "google_cloud_run_v2_job_iam_member" "scheduler_corpus_invoker" {
  project  = google_cloud_run_v2_job.railway_ingest_corpus.project
  location = google_cloud_run_v2_job.railway_ingest_corpus.location
  name     = google_cloud_run_v2_job.railway_ingest_corpus.name

  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.cloud_scheduler.email}"
}

resource "google_cloud_run_v2_job" "railway_ingest_schedule" {
  for_each = local.schedule_jobs

  project  = data.google_project.current.project_id
  name     = each.value.name
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.railway_ingest_runner.email

      max_retries = 0
      timeout     = "1200s"

      containers {
        image = local.default_cloud_run_job_image

        dynamic "env" {
          for_each = each.value.env

          content {
            name  = env.key
            value = env.value
          }
        }

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

resource "google_cloud_run_v2_job_iam_member" "railway_ingestion_ci_schedule_developer" {
  for_each = google_cloud_run_v2_job.railway_ingest_schedule

  project  = each.value.project
  location = each.value.location
  name     = each.value.name

  role   = "roles/run.developer"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}

resource "google_cloud_run_v2_job_iam_member" "scheduler_schedule_invoker" {
  for_each = google_cloud_run_v2_job.railway_ingest_schedule

  project  = each.value.project
  location = each.value.location
  name     = each.value.name

  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.cloud_scheduler.email}"
}

resource "google_cloud_run_v2_job" "railway_ingest_schedule_loader" {
  project  = data.google_project.current.project_id
  name     = "railway-ingest-schedule-loader"
  location = "europe-west1"

  deletion_protection = false

  template {
    template {
      service_account = google_service_account.railway_ingest_runner.email

      max_retries = 0
      timeout     = "1200s"

      containers {
        image = local.default_cloud_run_job_image

        env {
          name  = "SOURCE_BUCKET"
          value = google_storage_bucket.network_rail_open_data_raw.name
        }

        env {
          name  = "BQ_PROJECT"
          value = data.google_project.current.project_id
        }

        env {
          name  = "BQ_DATASET"
          value = google_bigquery_dataset.raw.dataset_id
        }

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

resource "google_cloud_run_v2_job_iam_member" "railway_ingestion_ci_schedule_loader_developer" {
  project  = google_cloud_run_v2_job.railway_ingest_schedule_loader.project
  location = google_cloud_run_v2_job.railway_ingest_schedule_loader.location
  name     = google_cloud_run_v2_job.railway_ingest_schedule_loader.name

  role   = "roles/run.developer"
  member = "serviceAccount:${data.google_service_account.railway_ingestion_ci.email}"
}

resource "google_cloud_run_v2_job_iam_member" "schedule_loader_workflow_executor" {
  project  = google_cloud_run_v2_job.railway_ingest_schedule_loader.project
  location = google_cloud_run_v2_job.railway_ingest_schedule_loader.location
  name     = google_cloud_run_v2_job.railway_ingest_schedule_loader.name

  role   = "roles/run.jobsExecutorWithOverrides"
  member = "serviceAccount:${google_service_account.schedule_loader_workflow.email}"
}