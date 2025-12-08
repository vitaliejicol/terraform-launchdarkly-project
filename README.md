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
  source = "https://github.com/vitaliejicol/terraform-launchdarkly-project.git"

  project_key = "example-project"
  project_name = "Example Project"
  tags = ["terraform"]

  environments = [
    {
      key   = "production"
      name  = "Production"
      color = "eeeeee"
      tags  = ["terraform"]
      approval_settings = {
        can_review_own_request     = false
        can_apply_declined_changes = false
      }
    },
    {
      key   = "staging"
      name  = "Staging"
      color = "000000"
      tags  = ["terraform"]
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | List of environments to create in the project. | <pre>list(object({<br/>    key   = string<br/>    name  = string<br/>    color = string<br/>    tags  = list(string)<br/>    approval_settings = optional(object({<br/>      can_review_own_request     = bool<br/>      can_apply_declined_changes = bool<br/>      min_num_approvals          = number<br/>      required_approval_tags     = list(string)<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_launchdarkly_access_token"></a> [launchdarkly\_access\_token](#input\_launchdarkly\_access\_token) | Your LaunchDarkly personal access token | `string` | n/a | yes |
| <a name="input_project_key"></a> [project\_key](#input\_project\_key) | The key of the LaunchDarkly project. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the LaunchDarkly project. | `string` | n/a | yes |
| <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags) | Tags for the project. | `list(string)` | `[]` | no |

## Outputs
sx
| Name | Description |
|------|-------------|
| <a name="output_project_key"></a> [project\_key](#output\_project\_key) | The key of the LaunchDarkly project. |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | The name of the LaunchDarkly project. |
| <a name="output_project_tags"></a> [project\_tags](#output\_project\_tags) | values of the tags for the project. |
<!-- END_TF_DOCS -->