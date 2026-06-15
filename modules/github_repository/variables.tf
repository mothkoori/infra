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
