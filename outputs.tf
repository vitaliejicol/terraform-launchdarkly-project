output "project_key" {
  description = "The key of the LaunchDarkly project."
  value = launchdarkly_project.this.key
}
output "project_name" {
  description = "The name of the LaunchDarkly project."
  value = launchdarkly_project.this.name
}
output "project_tags" {
  description = "values of the tags for the project."
  value = launchdarkly_project.this.tags
}