# presets.tf (In the root directory)

locals {
  repo_presets = {

    # Fully expanded Group Option: Best for core APIs and backend apps
    microservice = {
      has_issues                 = true
      has_projects               = false
      has_wiki                   = false
      has_downloads              = false
      allow_squash_merge         = true  # Enforce squash for clean main histories
      allow_merge_commit         = false # Disable standard merge commits
      allow_rebase_merge         = false
      delete_branch_on_merge     = true # Auto cleanup merged branches
      required_reviewers         = 2    # Requires two pair of eyes
      dismiss_stale_reviews      = true # Require fresh review if new code is pushed
      require_code_owner_reviews = true # Code owners must weigh in
    }

    # You can add other groups here later (frontend, sandbox, etc.),
    # just make sure they include all 11 fields defined above!
  }
}
