terraform {
  backend "gcs" {
    bucket = "railway-analytics-508615-terraform-state"
    prefix = "bootstrap"
  }
}