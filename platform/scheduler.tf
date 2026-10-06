resource "google_cloud_scheduler_job" "corpus_saturday" {
  project     = data.google_project.current.project_id
  region      = "europe-west1"
  name        = "railway-ingest-corpus-saturday"
  description = "Run CORPUS ingest three times on Saturday"

  schedule  = "0 1,9,17 * * 6"
  time_zone = "Europe/London"

  http_target {
    http_method = "POST"

    uri = "https://run.googleapis.com/v2/projects/${data.google_project.current.project_id}/locations/${google_cloud_run_v2_job.railway_ingest_corpus.location}/jobs/${google_cloud_run_v2_job.railway_ingest_corpus.name}:run"

    body = base64encode("{}")

    headers = {
      "Content-Type" = "application/json"
    }

    oauth_token {
      service_account_email = google_service_account.cloud_scheduler.email
    }
  }

  retry_config {
    retry_count = 3
  }
}

resource "google_cloud_scheduler_job" "corpus_sunday_backstop" {
  project     = data.google_project.current.project_id
  region      = "europe-west1"
  name        = "railway-ingest-corpus-sunday-backstop"
  description = "Backstop CORPUS ingest on Sunday morning"

  schedule  = "0 9 * * 0"
  time_zone = "Europe/London"

  http_target {
    http_method = "POST"

    uri = "https://run.googleapis.com/v2/projects/${data.google_project.current.project_id}/locations/${google_cloud_run_v2_job.railway_ingest_corpus.location}/jobs/${google_cloud_run_v2_job.railway_ingest_corpus.name}:run"

    body = base64encode("{}")

    headers = {
      "Content-Type" = "application/json"
    }

    oauth_token {
      service_account_email = google_service_account.cloud_scheduler.email
    }
  }

  retry_config {
    retry_count = 3
  }
}

resource "google_cloud_scheduler_job" "schedule_update_early" {
  project     = data.google_project.current.project_id
  region      = "europe-west1"
  name        = "railway-ingest-schedule-update-early"
  description = "Run daily SCHEDULE update ingest before the freshness deadline"

  schedule  = "0 7 * * *"
  time_zone = "Europe/London"

  http_target {
    http_method = "POST"

    uri = "https://run.googleapis.com/v2/projects/${data.google_project.current.project_id}/locations/${google_cloud_run_v2_job.railway_ingest_schedule["update_early"].location}/jobs/${google_cloud_run_v2_job.railway_ingest_schedule["update_early"].name}:run"

    body = base64encode("{}")

    headers = {
      "Content-Type" = "application/json"
    }

    oauth_token {
      service_account_email = google_service_account.cloud_scheduler.email
    }
  }

  retry_config {
    retry_count = 3
  }
}

resource "google_cloud_scheduler_job" "schedule_update_deadline" {
  project     = data.google_project.current.project_id
  region      = "europe-west1"
  name        = "railway-ingest-schedule-update-deadline"
  description = "Run daily SCHEDULE update ingest with freshness required"

  schedule  = "0 11 * * *"
  time_zone = "Europe/London"

  http_target {
    http_method = "POST"

    uri = "https://run.googleapis.com/v2/projects/${data.google_project.current.project_id}/locations/${google_cloud_run_v2_job.railway_ingest_schedule["update_deadline"].location}/jobs/${google_cloud_run_v2_job.railway_ingest_schedule["update_deadline"].name}:run"

    body = base64encode("{}")

    headers = {
      "Content-Type" = "application/json"
    }

    oauth_token {
      service_account_email = google_service_account.cloud_scheduler.email
    }
  }

  retry_config {
    retry_count = 3
  }
}

resource "google_cloud_scheduler_job" "schedule_full" {
  project     = data.google_project.current.project_id
  region      = "europe-west1"
  name        = "railway-ingest-schedule-full"
  description = "Run weekly full SCHEDULE snapshot ingest"

  schedule  = "0 8 * * 3"
  time_zone = "Europe/London"

  http_target {
    http_method = "POST"

    uri = "https://run.googleapis.com/v2/projects/${data.google_project.current.project_id}/locations/${google_cloud_run_v2_job.railway_ingest_schedule["full"].location}/jobs/${google_cloud_run_v2_job.railway_ingest_schedule["full"].name}:run"

    body = base64encode("{}")

    headers = {
      "Content-Type" = "application/json"
    }

    oauth_token {
      service_account_email = google_service_account.cloud_scheduler.email
    }
  }

  retry_config {
    retry_count = 3
  }
}