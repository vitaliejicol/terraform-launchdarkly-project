resource "launchdarkly_project" "this" {
  key  = var.project_key
  name = var.project_name
  tags = var.project_tags

  dynamic "default_client_side_availability" {
    for_each = var.default_client_side_availability != null ? [1] : []
    content {
      using_environment_id = var.default_client_side_availability.using_environment_id
      using_mobile_key     = var.default_client_side_availability.using_mobile_key
    }
  }

  dynamic "environments" {
    for_each = var.environments
    content {
      key   = environments.value.key
      name  = environments.value.name
      color = environments.value.color

      tags                 = try(environments.value.tags, null)
      confirm_changes      = try(environments.value.confirm_changes, null)
      critical             = try(environments.value.critical, null)
      default_track_events = try(environments.value.default_track_events, null)
      default_ttl          = try(environments.value.default_ttl, null)
      require_comments     = try(environments.value.require_comments, null)
      secure_mode          = try(environments.value.secure_mode, null)

      dynamic "approval_settings" {
        for_each = try(environments.value.approval_settings, null) != null ? [1] : []
        content {
          auto_apply_approved_changes = try(environments.value.approval_settings.auto_apply_approved_changes, null)
          can_review_own_request      = try(environments.value.approval_settings.can_review_own_request, null)
          can_apply_declined_changes  = try(environments.value.approval_settings.can_apply_declined_changes, null)
          min_num_approvals           = try(environments.value.approval_settings.min_num_approvals, null)

          required               = try(environments.value.approval_settings.required, null)
          required_approval_tags = try(environments.value.approval_settings.required_approval_tags, null)

          service_kind   = try(environments.value.approval_settings.service_kind, null)
          service_config = try(environments.value.approval_settings.service_config, null)
        }
      }
    }
  }
}
