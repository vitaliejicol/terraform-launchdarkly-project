# Module name: terraform-launchdarkly-project

A reusable Terraform module to manage project using launchdarkly provider.

This module is designed for flexibility, reusability, and clean output. It supports multiple environments and adheres to Terraform best practices.

---

## 📦 Features

- Create and configure [resource type, e.g., LaunchDarkly Projects]
- Manage multiple environments per project
- Customize tags, colors, and approval settings
- Compatible with Terraform `1.x` and the [`launchdarkly` provider]

---

## 📝 Usage

<!-- Adjust the example to match your module structure -->

```hcl
module "project" {
  source = "terraform-launchdarkly-modules/terraform-launchdarkly-project"

  project_key = "example-project"
  project_name = "Example Project"
  tags = ["terraform"]

  environments = {
  production = {
    key   = "production"
    name  = "Production"
    color = "eeeeee"
    tags  = ["environment-terraform"]

    approval_settings = {
      can_review_own_request     = true
      can_apply_declined_changes = false
      required = true
      min_num_approvals = 1
      required_approval_tags = []
    }
  }

  staging = {
    key   = "staging"
    name  = "Staging"
    color = "000000"
    tags  = ["environment-terraform"]
    approval_settings = {
      can_review_own_request     = false
      can_apply_declined_changes = false
      required = true
      min_num_approvals = 1
      required_approval_tags = []

    }
  }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_client_side_availability"></a> [default\_client\_side\_availability](#input\_default\_client\_side\_availability) | Defines how client-side SDK keys and mobile SDK keys are exposed for each environment.<br/><br/>If provided, controls whether the environment uses environment IDs or mobile keys<br/>for client-side SDK initialization.<br/><br/>Set to null to accept LaunchDarkly defaults. | <pre>object({<br/>    using_environment_id = bool<br/>    using_mobile_key     = bool<br/>  })</pre> | `null` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | A map defining all environments that should be created in the LaunchDarkly project.<br/><br/>Each environment includes required metadata such as key, name, and color, and may optionally<br/>define approval settings and additional configuration such as TTL, tracking, security flags,<br/>or comment enforcement.<br/><br/>Environment key must be unique within the project. | <pre>map(object({<br/>    key   = string<br/>    name  = string<br/>    color = string<br/><br/>    # Optional environment-level settings<br/>    tags                 = optional(list(string), [])<br/>    confirm_changes      = optional(bool)<br/>    critical             = optional(bool)<br/>    default_track_events = optional(bool)<br/>    default_ttl          = optional(number)<br/>    require_comments     = optional(bool)<br/>    secure_mode          = optional(bool)<br/><br/>    # Optional approval workflow settings<br/>    approval_settings = optional(object({<br/>      required                      = optional(bool)<br/>      required_approval_tags        = optional(list(string))<br/>      auto_apply_approved_changes   = optional(bool)<br/>      can_review_own_request        = optional(bool)<br/>      can_apply_declined_changes    = optional(bool)<br/>      min_num_approvals             = optional(number)<br/>      service_kind                  = optional(string)<br/>      service_config                = optional(map(string))<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_launchdarkly_access_token"></a> [launchdarkly\_access\_token](#input\_launchdarkly\_access\_token) | The LaunchDarkly access token used by the Terraform provider to manage resources. Must have the required API scopes. | `string` | n/a | yes |
| <a name="input_project_key"></a> [project\_key](#input\_project\_key) | A unique key for the LaunchDarkly project. This must be globally unique within your LaunchDarkly organization. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The human-readable name of the LaunchDarkly project. | `string` | n/a | yes |
| <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags) | A list of tags to apply to the LaunchDarkly project for categorization or filtering. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_key"></a> [project\_key](#output\_project\_key) | The key of the LaunchDarkly project. |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | The name of the LaunchDarkly project. |
| <a name="output_project_tags"></a> [project\_tags](#output\_project\_tags) | values of the tags for the project. |
<!-- END_TF_DOCS -->