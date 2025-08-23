variable "feature_flags" {
  type = map(object({
    project_key = string
    key         = string
    name        = string
    description = optional(string)
    variation_type = string

    variations = list(object({
      name        = string
      value       = any
      description = optional(string)
    }))

    defaults = object({
      on_variation  = number
      off_variation = number
    })

    client_side_availability = optional(object({
      using_environment_id = optional(bool)
      using_mobile_key     = optional(bool)
    }))

    tags = optional(list(string))
  }))
}


variable "launchdarkly_access_token" {
  description = "Your LaunchDarkly personal access token"
  type        = string
  sensitive   = true
}
