variable project_key {
  description = "The key of the LaunchDarkly project."
  type        = string
}

variable project_name {
  description = "The name of the LaunchDarkly project."
  type        = string
}

variable project_tags {
  description = "Tags for the project."
  type        = list(string)
  default     = []
}

variable "environments" {
  type = map(object({
    key   = string
    name  = string
    color = string

    tags                 = optional(list(string))
    confirm_changes      = optional(bool)
    critical             = optional(bool)
    default_track_events = optional(bool)
    default_ttl          = optional(number)
    require_comments     = optional(bool)
    secure_mode          = optional(bool)

    approval_settings = optional(object({
      auto_apply_approved_changes = optional(bool)
      can_review_own_request      = optional(bool)
      can_apply_declined_changes  = optional(bool)
      min_num_approvals           = optional(number)

      # Mutually exclusive rule: either these tags OR required = true
      # required               = optional(bool)
      # required_approval_tags = optional(list(string))

      service_kind   = optional(string)
      service_config = optional(map(string))
    }))
  }))
}


variable "default_client_side_availability" {
  type = object({
    using_environment_id = bool
    using_mobile_key     = bool
  })
  default = null
}

variable launchdarkly_access_token {
  description = "Your LaunchDarkly personal access token"
  type        = string
  sensitive   = true
}
