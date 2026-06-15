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

# The new variable that accepts the entire preset configuration package
variable "presets" {
  type = object({
    has_issues         = bool
    has_projects       = bool
    has_wiki           = bool
    allow_squash_merge = bool
    allow_merge_commit = bool
    required_reviewers = number
  })
  description = "A configuration package containing all repository feature presets"
}
