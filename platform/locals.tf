locals {
  project_id                  = "railway-analytics-508615"
  default_cloud_run_job_image = "europe-west1-docker.pkg.dev/railway-analytics-508615/railway-containers/cloud-run-bootstrap@sha256:2d9ddc91c418e7d47e928c4ffc991979f4efae8e84cf44138941b00b3e2a311f"

  schedule_jobs = {
    update_early = {
      name = "railway-ingest-schedule-update-early"

      env = {
        FULL_SNAPSHOT             = "false"
        REQUIRE_FRESH_PUBLICATION = "false"
      }
    }

    update_deadline = {
      name = "railway-ingest-schedule-update-deadline"

      env = {
        FULL_SNAPSHOT             = "false"
        REQUIRE_FRESH_PUBLICATION = "true"
      }
    }

    full = {
      name = "railway-ingest-schedule-full"

      env = {
        FULL_SNAPSHOT             = "true"
        REQUIRE_FRESH_PUBLICATION = "false"
      }
    }
  }
}