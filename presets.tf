# presets.tf (In the root directory)

# presets.tf (In the root directory)

locals {
  repo_presets = {
    microservice = {
      has_issues             = true
      has_projects           = false
      has_wiki               = false
      has_downloads          = false
      allow_squash_merge     = true
      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
      required_reviewers     = 2

      # FIX: Ensure these two lines are present and spelled exactly like this:
      dismiss_stale_reviews      = true
      require_code_owner_reviews = true

      release_branch_pattern = "release/*"
      bypass_actors_teams    = ["devops-admins"]
    }
  }
}
