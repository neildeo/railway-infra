resource "google_bigquery_dataset" "raw" {
  project     = data.google_project.current.project_id
  dataset_id  = "raw"
  location    = "EU"
  description = "Raw landing data for railway analytics project. No complex structural invariants beyond non-nullability are enforced at this layer - such contracts reside in the staging layer."

  delete_contents_on_destroy = false
}

resource "google_bigquery_table" "schedule_publications" {
  project     = data.google_project.current.project_id
  dataset_id  = google_bigquery_dataset.raw.dataset_id
  table_id    = "schedule_publications"
  description = "Publication headers for SCHEDULE extracts"

  schema = file(
    "${path.module}/schemas/raw/schedule/schedule_publications.json"
  )

  deletion_protection = true
}

resource "google_bigquery_table" "schedule_tiplocs" {
  project     = data.google_project.current.project_id
  dataset_id  = google_bigquery_dataset.raw.dataset_id
  table_id    = "schedule_tiplocs"
  description = "Timing point locations for schedules"

  schema = file(
    "${path.module}/schemas/raw/schedule/schedule_tiplocs.json"
  )

  clustering = [
    "publication_sequence",
  ]

  deletion_protection = true
}

resource "google_bigquery_table" "schedule_associations" {
  project     = data.google_project.current.project_id
  dataset_id  = google_bigquery_dataset.raw.dataset_id
  table_id    = "schedule_associations"
  description = "Associations between schedules"

  schema = file(
    "${path.module}/schemas/raw/schedule/schedule_associations.json"
  )

  clustering = [
    "publication_sequence",
  ]

  deletion_protection = true
}

resource "google_bigquery_table" "schedule_schedules" {
  project     = data.google_project.current.project_id
  dataset_id  = google_bigquery_dataset.raw.dataset_id
  table_id    = "schedule_schedules"
  description = "Actual schedules, including locations and service characteristics"

  schema = file(
    "${path.module}/schemas/raw/schedule/schedule_schedules.json"
  )

  clustering = [
    "publication_sequence",
  ]

  deletion_protection = true
}