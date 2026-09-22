resource "google_storage_bucket_iam_member" "terraform_state_object_admin" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.objectAdmin"
  member = google_service_account.terraform_ci.member
}

resource "google_storage_bucket_iam_member" "terraform_ci_artifacts_object_user" {
  bucket = google_storage_bucket.terraform_artifacts.name
  role   = "roles/storage.objectUser"
  member = google_service_account.terraform_ci.member
}