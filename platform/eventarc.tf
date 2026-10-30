resource "google_service_account" "schedule_loader_eventarc" {
  project      = data.google_project.current.project_id
  account_id   = "schedule-loader-eventarc"
  display_name = "SCHEDULE loader Eventarc trigger"
}

resource "google_project_iam_member" "schedule_loader_eventarc_event_receiver" {
  project = data.google_project.current.project_id
  role    = "roles/eventarc.eventReceiver"

  member = "serviceAccount:${google_service_account.schedule_loader_eventarc.email}"
}

resource "google_project_iam_member" "schedule_loader_eventarc_workflows_invoker" {
  project = data.google_project.current.project_id
  role    = "roles/workflows.invoker"

  member = "serviceAccount:${google_service_account.schedule_loader_eventarc.email}"
}

resource "google_project_iam_member" "cloud_storage_pubsub_publisher" {
  project = data.google_project.current.project_id
  role    = "roles/pubsub.publisher"

  member = "serviceAccount:service-${data.google_project.current.number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_eventarc_trigger" "schedule_object_finalized" {
  project  = data.google_project.current.project_id
  name     = "schedule-object-finalized"
  location = "eu"

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.network_rail_open_data_raw.name
  }

  destination {
    workflow = google_workflows_workflow.schedule_loader.id
  }

  service_account = google_service_account.schedule_loader_eventarc.email

  depends_on = [
    google_project_iam_member.schedule_loader_eventarc_event_receiver,
    google_project_iam_member.schedule_loader_eventarc_workflows_invoker,
    google_project_iam_member.cloud_storage_pubsub_publisher,
  ]
}