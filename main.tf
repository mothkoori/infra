terraform {
  required_version = ">= 1.0.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  # Token credentials are loaded implicitly from the environment (GITHUB_TOKEN)
}

# Add your repositories below by duplicating this module block:
module "project_alpha" {
  source      = "./modules/github_repository"
  repo_name   = "project-alpha-api"
  visibility  = "public"
  description = "Core backend API for Project Alpha"
}

module "project_beta" {
  source     = "./modules/github_repository"
  repo_name  = "project-beta-ui"
  visibility = "public"
}