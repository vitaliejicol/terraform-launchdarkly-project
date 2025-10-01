resource "launchdarkly_project" "this" {
  key  = var.project_key
  name = var.project_name
  tags = var.project_tags

  dynamic "environments" {
    for_each = var.environments
    content {
      key   = environments.value.key
      name  = environments.value.name
      color = environments.value.color
      tags  = environments.value.tags

      dynamic "approval_settings" {
        for_each = try(environments.value.approval_settings, null) != null ? [1] : []
        content {
          can_review_own_request     = environments.value.approval_settings.can_review_own_request
          can_apply_declined_changes = environments.value.approval_settings.can_apply_declined_changes
          # Only set min_num_approvals if it’s passed in
          min_num_approvals          = try(environments.value.approval_settings.min_num_approvals, null)
          required_approval_tags     = environments.value.approval_settings.required_approval_tags
        }
      }
    }
  }
}
