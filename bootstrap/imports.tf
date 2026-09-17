import {
  to = google_storage_bucket.terraform_state
  id = "railway-analytics-508615-terraform-state"
}

import {
  to = google_service_account.terraform_ci
  id = "projects/railway-analytics-508615/serviceAccounts/terraform-ci@railway-analytics-508615.iam.gserviceaccount.com"
}