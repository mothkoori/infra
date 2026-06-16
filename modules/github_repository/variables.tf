# modules/github_repository/variables.tf

variable "repo_name" {
  type        = string
  description = "The name of the GitHub repository"
}

variable "description" {
  type        = string
  description = "The description of the repository"
  default     = "Managed by Terraform"
}

variable "visibility" {
  type        = string
  description = "Visibility of the repo: public or private"
  default     = "private"
}

# modules/github_repository/variables.tf

variable "presets" {
  type = object({
    has_issues                 = bool
    has_projects               = bool
    has_wiki                   = bool
    has_downloads              = bool
    allow_squash_merge         = bool
    allow_merge_commit         = bool
    allow_rebase_merge         = bool
    delete_branch_on_merge     = bool
    required_reviewers         = number
    dismiss_stale_reviews      = bool # Ensure this spelling
    require_code_owner_reviews = bool # Ensure this spelling
    release_branch_pattern     = string
    bypass_actors_teams        = list(string)
  })
}
