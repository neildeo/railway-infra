resource "google_storage_bucket" "terraform_state" {
  name     = "railway-analytics-508615-terraform-state"
  location = "EU"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      num_newer_versions = 20
      with_state         = "ARCHIVED"
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      days_since_noncurrent_time = 30
      with_state                 = "ANY"
    }
  }

  encryption {
    google_managed_encryption_enforcement_config {
      restriction_mode = "NotRestricted"
    }

    customer_managed_encryption_enforcement_config {
      restriction_mode = "NotRestricted"
    }

    customer_supplied_encryption_enforcement_config {
      restriction_mode = "FullyRestricted"
    }
  }
}


resource "google_storage_bucket" "terraform_artifacts" {
  name     = local.terraform_artifacts_bucket_name
  location = "EU"

  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  soft_delete_policy {
    retention_duration_seconds = 0
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 1
    }
  }
}