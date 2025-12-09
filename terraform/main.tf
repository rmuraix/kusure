data "google_project" "project" {
}

module "api" {
  source = "./module/api"
}

module "iam" {
  source         = "./module/iam"
  depends_on     = [module.api]
  project_id     = var.project_id
  project_number = data.google_project.project.number
}

module "secretmanager" {
  source          = "./module/secretmanager"
  depends_on      = [module.api]
  repository_name = var.repository_name

  github_token              = var.github_token
  line_channel_access_token = var.line_channel_access_token
  line_channel_secret       = var.line_channel_secret
}

module "artifactregistory" {
  source     = "./module/artifactregistory"
  depends_on = [module.api]
  region     = var.region
}

module "cloudbuild" {
  source              = "./module/cloudbuild"
  depends_on          = [module.iam, module.secretmanager, module.artifactregistory]
  project_id          = var.project_id
  repository_group    = var.repository_group
  repository_name     = var.repository_name
  region              = var.region
  github_secret_id    = module.secretmanager.github_secret_id
  app_installation_id = var.app_installation_id
}

module "cloudrun" {
  source                       = "./module/cloudrun"
  depends_on                   = [module.cloudbuild]
  project_id                   = var.project_id
  repository_name              = var.repository_name
  region                       = var.region
  line_channel_secret_id       = module.secretmanager.line_channel_secret_id
  line_channel_access_token_id = module.secretmanager.line_channel_access_token_id
}
