resource "google_privileged_access_manager_entitlement" "terraform_apply" {
  entitlement_id       = "terraform-apply"
  location             = "global"
  parent               = "projects/${local.project_id}"
  max_request_duration = "1800s"

  eligible_users {
    principals = [
      google_service_account.terraform_ci.member,
    ]
  }

  requester_justification_config {
    unstructured {}
  }

  privileged_access {
    gcp_iam_access {
      resource_type = "cloudresourcemanager.googleapis.com/Project"
      resource      = "//cloudresourcemanager.googleapis.com/projects/${local.project_id}"

      role_bindings {
        role = google_project_iam_custom_role.terraform_apply.name
      }

      role_bindings {
        role = "roles/storage.admin"

        condition_expression = <<-EOT
          (
            resource.type == "storage.googleapis.com/Bucket" ||
            resource.type == "storage.googleapis.com/Object"
          ) &&
          resource.name.startsWith(
            "projects/_/buckets/${local.network_rail_raw_bucket_name}"
          )
        EOT
      }
    }
  }

  approval_workflow {
    manual_approvals {
      require_approver_justification = true

      steps {
        approvals_needed = 1

        approvers {
          principals = [
            local.pam_approver_principal,
          ]
        }
      }
    }
  }
}