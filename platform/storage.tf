resource "google_storage_bucket" "network_rail_open_data_raw" {
  name     = "${local.project_id}-network-rail-open-data-raw"
  location = "EU"

  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  deletion_policy             = "PREVENT"

  versioning {
    enabled = true
  }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }
}

resource "google_storage_bucket_iam_member" "railway_ingest_runner_raw_object_user" {
  bucket = google_storage_bucket.network_rail_open_data_raw.name
  role   = "roles/storage.objectUser"

  member = "serviceAccount:${google_service_account.railway_ingest_runner.email}"
}

resource "google_storage_bucket_iam_member" "schedule_load_backfill_raw_object_viewer" {
  bucket = google_storage_bucket.network_rail_open_data_raw.name
  role   = "roles/storage.objectViewer"

  member = "serviceAccount:${google_service_account.schedule_load_backfill.email}"
}