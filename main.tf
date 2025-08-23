resource "launchdarkly_feature_flag" "this" {
  for_each = var.feature_flags

  project_key     = each.value.project_key
  key             = each.value.key
  name            = each.value.name
  description     = try(each.value.description, null)
  variation_type  = each.value.variation_type
  tags            = try(each.value.tags, null)

  dynamic "variations" {
    for_each = each.value.variations
    content {
      name        = variations.value.name
      value       = variations.value.value
      description = try(variations.value.description, null)
    }
  }

  dynamic "client_side_availability" {
    for_each = each.value.client_side_availability != null ? [each.value.client_side_availability] : []
    content {
      using_environment_id = try(client_side_availability.value.using_environment_id, null)
      using_mobile_key     = try(client_side_availability.value.using_mobile_key, null)
    }
  }

  defaults {
    on_variation  = each.value.defaults.on_variation
    off_variation = each.value.defaults.off_variation
  }
}
