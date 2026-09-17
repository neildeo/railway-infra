import {
  to = google_storage_bucket.terraform_state
  id = "railway-analytics-508615-terraform-state"
}

import {
  to = google_service_account.terraform_ci
  id = "projects/railway-analytics-508615/serviceAccounts/terraform-ci@railway-analytics-508615.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.terraform_ci_browser

  identity = {
    project = "railway-analytics-508615"
    role    = "roles/browser"
    member  = "serviceAccount:terraform-ci@railway-analytics-508615.iam.gserviceaccount.com"
  }
}

import {
  to = google_storage_bucket_iam_member.terraform_state_object_admin
  id = "b/railway-analytics-508615-terraform-state roles/storage.objectAdmin serviceAccount:terraform-ci@railway-analytics-508615.iam.gserviceaccount.com"
}