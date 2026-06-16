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
      require_code_owner_reviews      = var.presets.require_code_owner_reviews

      # REQUIREMENT: If an update happens to a PR, the approval is invalidated
      dismiss_stale_reviews_on_push = var.presets.dismiss_stale_reviews

      # REQUIREMENT: The person who committed the code cannot review/approve their own PR
      require_last_push_approval = true
    }

    # REQUIREMENT: Prevent release and main branches from being deleted
    deletion = true
  }
}

# 3. Repository Lifecycle Ruleset (Handles Admin/Group protections)
resource "github_repository_ruleset" "repo_lifecycle" {
  name        = "repo-lifecycle-policy"
  repository  = github_repository.repo.name
  target      = "repository"
  enforcement = "active"

  # REQUIREMENT: Only specific admin groups can delete the repository itself
  # We use bypass actors. If you are in the bypass list, you can delete it. Everyone else is blocked.
  dynamic "bypass_actors" {
    for_each = var.presets.bypass_actors_teams
    content {
      actor_id    = 1 # Note: In production organization environments, you map the GitHub Team ID here
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }

  rules {
    creation = false
    update   = false

    # Restricts deletion of the repository to everyone except the bypass actors list
    deletion = true
  }
}
