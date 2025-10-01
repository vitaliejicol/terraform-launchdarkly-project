variable "project_key" {
  description = "The key of the LaunchDarkly project."
  type        = string
}

variable "project_name" {
  description = "The name of the LaunchDarkly project."
  type        = string
}

variable "project_tags" {
  description = "Tags for the project."
  type        = list(string)
  default     = []
}

variable "environments" {
  type = map(object({
    key   = string
    name  = string
    color = string
    tags  = list(string)
    approval_settings = optional(object({
      can_review_own_request     = bool
      can_apply_declined_changes = bool
      min_num_approvals          = number
      required_approval_tags     = list(string)
    }))
  }))
}



variable "launchdarkly_access_token" {
  description = "Your LaunchDarkly personal access token"
  type        = string
  sensitive   = true
}
