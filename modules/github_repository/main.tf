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

  # Core Features
  has_issues    = var.presets.has_issues
  has_projects  = var.presets.has_projects
  has_wiki      = var.presets.has_wiki
  has_downloads = var.presets.has_downloads

  # Merge Strategies
  allow_squash_merge     = var.presets.allow_squash_merge
  allow_merge_commit     = var.presets.allow_merge_commit
  allow_rebase_merge     = var.presets.allow_rebase_merge
  delete_branch_on_merge = var.presets.delete_branch_on_merge

  auto_init = true
}

resource "github_branch_protection" "main" {
  count = var.visibility == "public" ? 1 : 0

  repository_id = github_repository.repo.node_id
  pattern       = "main"

  enforce_admins   = true
  allows_deletions = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = var.presets.dismiss_stale_reviews
    required_approving_review_count = var.presets.required_reviewers
    require_code_owner_reviews      = var.presets.require_code_owner_reviews
  }
}
