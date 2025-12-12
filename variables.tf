variable "project_key" {
  description = "A unique key for the LaunchDarkly project. This must be globally unique within your LaunchDarkly organization."
  type        = string
}

variable "project_name" {
  description = "The human-readable name of the LaunchDarkly project."
  type        = string
}

variable "project_tags" {
  description = "A list of tags to apply to the LaunchDarkly project for categorization or filtering."
  type        = list(string)
  default     = []
}

variable "environments" {
  description = <<EOF
A map defining all environments that should be created in the LaunchDarkly project.

Each environment includes required metadata such as key, name, and color, and may optionally
define approval settings and additional configuration such as TTL, tracking, security flags,
or comment enforcement.

Environment key must be unique within the project.
EOF
  type = map(object({
    key   = string
    name  = string
    color = string

    # Optional environment-level settings
    tags                 = optional(list(string), [])
    confirm_changes      = optional(bool)
    critical             = optional(bool)
    default_track_events = optional(bool)
    default_ttl          = optional(number)
    require_comments     = optional(bool)
    secure_mode          = optional(bool)

    # Optional approval workflow settings
    approval_settings = optional(object({
      required                    = optional(bool)
      required_approval_tags      = optional(list(string))
      auto_apply_approved_changes = optional(bool)
      can_review_own_request      = optional(bool)
      can_apply_declined_changes  = optional(bool)
      min_num_approvals           = optional(number)
      service_kind                = optional(string)
      service_config              = optional(map(string))
    }))
  }))
}

variable "default_client_side_availability" {
  description = <<EOF
Defines how client-side SDK keys and mobile SDK keys are exposed for each environment.

If provided, controls whether the environment uses environment IDs or mobile keys
for client-side SDK initialization.

Set to null to accept LaunchDarkly defaults.
EOF
  type = object({
    using_environment_id = bool
    using_mobile_key     = bool
  })
  default = null
}

variable "launchdarkly_access_token" {
  description = "The LaunchDarkly access token used by the Terraform provider to manage resources. Must have the required API scopes."
  type        = string
  sensitive   = true
}
