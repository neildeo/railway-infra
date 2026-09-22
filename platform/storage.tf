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