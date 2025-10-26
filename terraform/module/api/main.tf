terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64.0"
    }
  }
  required_version = ">= 1.3"
}

variable "gcp_service_list" {
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}

resource "google_project_service" "main" {
  for_each = toset(var.gcp_service_list)
  service  = each.key

  disable_on_destroy = false
}
