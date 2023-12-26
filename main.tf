
# ---------------------------------------------------------------------------------------------------------------------
# LOCAL VALUE
# ---------------------------------------------------------------------------------------------------------------------


locals {
  services = [
    "sourcerepo.googleapis.com",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# ENABLED THE API SERVICE
# ---------------------------------------------------------------------------------------------------------------------

resource "google_project_service" "enabled_service" {
  for_each = toset(local.services)
  project  = var.project
  service  = each.key
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A GOOGLE CLOUD SOURCE REPOSITORY
# ---------------------------------------------------------------------------------------------------------------------

resource "google_sourcerepo_repository" "repo" {
  name = var.repository_name
  depends_on = [
    google_project_service.enabled_service["sourcerepo.googleapis.com"]
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CLOUD BUILD TRIGGER
# ---------------------------------------------------------------------------------------------------------------------

resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  description = "Cloud Source Repository Trigger ${var.repository_name} (${var.branch_name})"

  trigger_template {
    branch_name = var.branch_name
    repo_name   = var.repository_name
  }

  substitutions = {
    _LOCATION   = var.location
    _GCR_REGION = var.gcr_region
  }

  filename = "cloudbuild.yaml"
  included_files = [
    "*"
  ]

  depends_on = [google_sourcerepo_repository.repo]
}
