
/* Amazon ECS Container Instance IAM Role
   IAM role that EC2 instances will assume when created by the auto-scaling group. If 
   this was created by ECS's First Run utility, it would be named ecsInstanceRole.  
   More information in the ECS documentation:
   http://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html */
resource "aws_iam_role" "TerraformedEcsInstanceRole" {
  name = "TerraformedEcsInstanceRole"
  assume_role_policy = "${file("${path.module}/policies/instance-assume-role.json")}"
}

/* We duplicated the preexisting Amazon supplied policy, because Terraform will de-associate 
   a policy from all roles NOT referenced in the aws_iam_policy_attachment resource, ie - if
   someone has a role that references the Amazon supplied policy and they use this module the
   policy will be revoked from their role. Likely causing some very painful debugging on their
   part. This has the downside of having to maintain a copy of the policy, but this seems 
   preferable to the possibility of we could blow away someone else's role permissions. */
resource "aws_iam_policy" "TerraformedAmazonEC2ContainerServiceforEC2Role" {
    name = "TerraformedAmazonEC2ContainerServiceforEC2Role"
    path = "/"
    description = "Copy of the AmazonEC2ContainerServiceforEC2Role Policy"
    policy = "${file("${path.module}/policies/ecs-instance-role-policy.json")}"
}

/* Attach the policy to our role. */
resource "aws_iam_policy_attachment" "ecs-instance-attach-role-policy" {
  name = "ecs-instance-attach-role-policy"
  roles = ["${aws_iam_role.TerraformedEcsInstanceRole.name}"]
  policy_arn = "${aws_iam_policy.TerraformedAmazonEC2ContainerServiceforEC2Role.arn}"
}

/* Finally, the Instance Profile which will be referenced by the auto-scaling group. */
resource "aws_iam_instance_profile" "TerraformedEcsInstanceRole" {
  name  = "TerraformedEcsInstanceRole"
  path  = "/"
  roles = ["${aws_iam_role.TerraformedEcsInstanceRole.name}"]
}









/* Amazon ECS Service Scheduler IAM Role
   Allows the ECS Scheduler Service to register/deregister container instances with 
   an ELB.  For more info, see:
   http://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_IAM_role.html
   When created by the First Run utility, this role is known as ecsServiceRole. */
resource "aws_iam_role" "TerraformedEcsServiceRole" {
  name = "TerraformedEcsServiceRole"
  assume_role_policy = "${file("${path.module}/policies/service-assume-role.json")}"
}

/* Copy the Amazon supplied AmazonEC2ContainerServiceRole policy. See description of
   the TerraformedAmazonEC2ContainerServiceforEC2Role policy for an explination of why
   we would want to do this. */
resource "aws_iam_policy" "TerraformedAmazonEC2ContainerServiceRole" {
    name = "TerraformedAmazonEC2ContainerServiceRole"
    path = "/"
    description = "Copy of the AmazonEC2ContainerServiceRole Policy"
    policy = "${file("${path.module}/policies/ecs-service-role-policy.json")}"
}

/* Attach the copy of the policy to our role. */
resource "aws_iam_policy_attachment" "ecs-service-attach-role-policy" {
  name = "ecs-service-attach-role-policy"
  roles = ["${aws_iam_role.TerraformedEcsServiceRole.name}"]
  policy_arn = "${aws_iam_policy.TerraformedAmazonEC2ContainerServiceRole.arn}"
}

