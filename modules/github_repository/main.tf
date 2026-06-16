# modules/github_repository/main.tf

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# 1. Base Repository Creation
resource "github_repository" "repo" {
  name        = var.repo_name
  description = var.description
  visibility  = var.visibility

  has_issues             = var.presets.has_issues
  has_projects           = var.presets.has_projects
  has_wiki               = var.presets.has_wiki
  has_downloads          = var.presets.has_downloads
  allow_squash_merge     = var.presets.allow_squash_merge
  allow_merge_commit     = var.presets.allow_merge_commit
  allow_rebase_merge     = var.presets.allow_rebase_merge
  delete_branch_on_merge = var.presets.delete_branch_on_merge

  auto_init = true
}

# 2. Advanced Governance Ruleset (Applies to main & release branches)
resource "github_repository_ruleset" "branch_protection" {
  name        = "branch-governance-policy"
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  # Define which branches this strict ruleset protects
  conditions {
    ref_name {
      include = ["refs/heads/main", "refs/heads/${var.presets.release_branch_pattern}"]
      exclude = []
    }
  }

  # Rules configuration block
  rules {
    # REQUIREMENT: No direct commits allowed (forces Pull Requests)
    pull_request {
      required_approving_review_count = var.presets.required_reviewers

      # The ruleset field is singular, but it reads from your plural variable attribute
      require_code_owner_review = var.presets.require_code_owner_reviews

      # The ruleset field is 'on_push', but it reads from your variable attribute
      dismiss_stale_reviews_on_push = var.presets.dismiss_stale_reviews

      require_last_push_approval = true
    }

    # REQUIREMENT: Prevent release and main branches from being deleted
    deletion = true
  }
}

