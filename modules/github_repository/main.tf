# modules/github_repository/main.tf

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

  # Reading configurations straight from the preset variable package
  has_issues         = var.presets.has_issues
  has_projects       = var.presets.has_projects
  has_wiki           = var.presets.has_wiki
  allow_squash_merge = var.presets.allow_squash_merge
  allow_merge_commit = var.presets.allow_merge_commit

  auto_init          = true
  allow_rebase_merge = false
}

resource "github_branch_protection" "main" {
  count = var.visibility == "public" ? 1 : 0

  repository_id = github_repository.repo.node_id
  pattern       = "main"

  enforce_admins   = true
  allows_deletions = false

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    # Dynamically reading the reviewer count requirement
    required_approving_review_count = var.presets.required_reviewers
  }
}
