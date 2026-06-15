terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_repository" "repo" {
  name        = var.repo_name
  description = var.description
  visibility  = var.visibility

  # Presets / Standardized Templates
  has_issues         = true
  has_wiki           = false
  has_projects       = false
  auto_init          = true
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
}

resource "github_branch_protection" "main" {
  repository_id = github_repository.repo.node_id
  pattern       = "main"

  enforce_admins   = true
  allows_deletions = false

  required_pull_request_reviews {
    dismiss_stale_reviews       = true
    required_approving_review_count = 1
  }
}
