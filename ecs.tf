/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  name     = "ecs"
  image_id = "${lookup(var.amis, var.region)}"

  /* @todo - split out to a variable */
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ec2_key_pair_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.id}"
  security_groups             = ["${aws_security_group.ecs.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.name}"
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.default.name} > /etc/ecs/ecs.config"
  associate_public_ip_address = true
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  name                 = "ecs-asg"
  vpc_zone_identifier  = ["${split(",", var.vpc_subnet_ids)}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"

  min_size         = "${var.min_num_instances}"
  max_size         = "${var.max_num_instances}"
  desired_capacity = "${var.desired_num_instances}"
}

/* ecs service cluster */
resource "aws_ecs_cluster" "default" {
  name = "${var.ecs_cluster_name}"
}
