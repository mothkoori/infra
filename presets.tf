# presets.tf (In the root directory)

locals {
  repo_presets = {

    # Production Microservice Configuration Package
    microservice = {
      has_issues             = true
      has_projects           = false
      has_wiki               = false
      has_downloads          = false
      allow_squash_merge     = true
      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true

      # Ruleset Configuration Values
      required_reviewers         = 2    # 2 Approvals required
      dismiss_stale_reviews      = true # New pushes invalidate old approvals
      require_code_owner_review = true # Enforce code owners compliance

      release_branch_pattern = "release/*"       # Targets main AND release/* branches
      bypass_actors_teams    = ["devops-admins"] # Only members of this team bypass deletion blocks
    }
  }
}
