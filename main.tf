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

module "marketing_site" {
  source     = "./modules/github_repository"
  repo_name  = "marketing-landing-page"
  visibility = "public"

  # Pass the frontend preset group map package
  presets = local.repo_presets["frontend"]
}

module "user_guide" {
  source     = "./modules/github_repository"
  repo_name  = "developer-docs"
  visibility = "public"

  # Easily assign the new documentation configuration group
  presets = local.repo_presets["documentation"]
}
