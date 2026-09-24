locals {
  project_id             = "railway-analytics-508615"
  github_owner_id        = "164882710"
  github_repository_id   = "1370194288"
  railway_ingest_repo_id = "1384907199"

  terraform_artifacts_bucket_name = "${local.project_id}-terraform-artifacts"

  network_rail_raw_bucket_name = "${local.project_id}-network-rail-open-data-raw"

  pam_approver_principal = "user:neildeo42@gmail.com"
}