/* template files for ecs role policies */
resource "template_file" "ecs_service_role_policy" {
  filename = "policies/ecs-service-role-policy.json"

  vars {
  }
}
