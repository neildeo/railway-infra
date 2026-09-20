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

import {
  to = google_iam_workload_identity_pool.github_actions
  id = "projects/railway-analytics-508615/locations/global/workloadIdentityPools/github-actions"
}

import {
  to = google_iam_workload_identity_pool_provider.github_actions

  identity = {
    workload_identity_pool_id          = "github-actions"
    workload_identity_pool_provider_id = "github-actions"
    project                            = "railway-analytics-508615"
  }
}

import {
  to = google_service_account_iam_member.terraform_ci_wif

  identity = {
    service_account_id = "projects/railway-analytics-508615/serviceAccounts/terraform-ci@railway-analytics-508615.iam.gserviceaccount.com"
    role               = "roles/iam.workloadIdentityUser"
    member             = "principalSet://iam.googleapis.com/projects/955463760385/locations/global/workloadIdentityPools/github-actions/attribute.repository_id/1370194288"
  }
}