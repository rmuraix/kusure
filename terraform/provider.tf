terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.64.0"
    }
  }
  required_version = ">= 1.3"
}

locals {
  credentials = var.service_account_key != "" ? file("./key/${var.service_account_key}") : null
}

provider "google" {
  project     = var.project_id
  region      = "asia-northeast1"
  credentials = local.credentials
}

provider "google-beta" {
  project     = var.project_id
  region      = "asia-northeast1"
  credentials = local.credentials
}
