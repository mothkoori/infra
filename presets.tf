# presets.tf (In the root directory)

locals {
  repo_presets = {

    # Preset Group 1: Microservices
    microservice = {
      has_issues         = true
      has_projects       = false
      has_wiki           = false
      allow_squash_merge = true
      allow_merge_commit = false
      required_reviewers = 2
    }

    # Preset Group 2: Frontend applications
    frontend = {
      has_issues         = true
      has_projects       = true
      has_wiki           = false
      allow_squash_merge = false
      allow_merge_commit = true
      required_reviewers = 1
    }

    # Preset Group 3: Documentation / Open Source
    documentation = {
      has_issues         = false
      has_projects       = false
      has_wiki           = true
      allow_squash_merge = true
      allow_merge_commit = true
      required_reviewers = 1
    }
  }
}
