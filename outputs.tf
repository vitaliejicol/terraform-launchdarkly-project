output "feature_flag_keys" {
  value = { for k, f in launchdarkly_feature_flag.this : k => f.key }
}

output "feature_flag_ids" {
  value = { for k, f in launchdarkly_feature_flag.this : k => f.id }
}
