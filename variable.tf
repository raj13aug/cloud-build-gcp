# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------


variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "location" {
  description = "The location (region or zone) to deploy the Cloud Run services. Note: Be sure to pick a region that supports Cloud Run."
  type        = string
}

variable "gcr_region" {
  description = "Name of the GCP region where the GCR registry is located. e.g: 'us' or 'eu'."
  type        = string
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------


variable "repository_name" {
  description = "Name of the Google Cloud Source Repository to create."
  type        = string
  default     = "sample-docker-app"
}

variable "branch_name" {
  description = "Example branch name used to trigger builds."
  type        = string
  default     = "master"
}