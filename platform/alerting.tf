resource "google_monitoring_notification_channel" "email" {
  project      = data.google_project.current.project_id
  display_name = "Railway alerts"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_alert_policy" "cloud_run_job_failure" {
  project      = data.google_project.current.project_id
  display_name = "Cloud Run job failure"
  combiner     = "OR"

  conditions {
    display_name = "Failed Cloud Run job execution"

    condition_threshold {
      filter = <<-EOT
        resource.type = "cloud_run_job"
        AND metric.type = "run.googleapis.com/job/completed_execution_count"
        AND metric.label.result = "failed"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "0s"

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_SUM"
        cross_series_reducer = "REDUCE_SUM"

        group_by_fields = [
          "resource.label.job_name",
          "resource.label.location",
        ]
      }
    }
  }

  # $${} is used to escape Terraform's string interpolation and 
  # use GCP Alerting's interpolation instead
  documentation {
    mime_type = "text/markdown"

    subject = "Cloud Run job failed: $${resource.label.job_name}"

    content = <<-EOT
    ## Cloud Run job execution failed

    **Job:** `$${resource.label.job_name}`  
    **Location:** `$${resource.label.location}`  
    **Project:** `$${resource.project}`

    A Cloud Run Job execution completed with a failed result.

    Use the **View job logs** link below to investigate the failure.
  EOT

    links {
      display_name = "View job logs"

      url = "https://console.cloud.google.com/logs/query;query=resource.type%3D%22cloud_run_job%22%0Aresource.labels.job_name%3D%22$${resource.label.job_name}%22%0Aresource.labels.location%3D%22$${resource.label.location}%22;duration=PT1H?project=$${resource.project}"
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name,
  ]
}