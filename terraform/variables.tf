variable "region" {
  type        = string
  description = "region"
  default     = "asia-east1"
}

variable "service_account_key" {
  type        = string
  description = "gcp project service account key file path"
  default     = ""
}

variable "project_id" {
  type        = string
  description = "gcp project id"
}

variable "repository_group" {
  type        = string
  description = "repository group"
  default     = "rmuraix"
}

variable "repository_name" {
  type        = string
  description = "repository name"
  default     = "kusuRe"
}

variable "app_installation_id" {
  type        = number
  description = "GitHub App installation ID"
  default     = 65399203
}

variable "github_token" {
  type        = string
  description = "GitHub token for accessing repositories"
  sensitive   = true
  default     = ""
}

variable "line_channel_access_token" {
  type        = string
  description = "LINE channel access token"
  sensitive   = true
  default     = ""
}

variable "line_channel_secret" {
  type        = string
  description = "LINE channel secret"
  sensitive   = true
  default     = ""
}

