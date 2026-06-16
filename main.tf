# main.tf (Root directory)

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {}


# --- Repository Creations ---

module "order_api" {
  source     = "./modules/github_repository"
  repo_name  = "order-processing-service"
  visibility = "public"

  # Pass the entire microservice preset group map package
  presets = local.repo_presets["microservice"]
}

