resource "aws_launch_configuration" "mylc" {
  name_prefix          = "MyLC"
  image_id             = lookup(var.amis, var.region)
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.myasg-s3-role-profile.name
  key_name             = aws_key_pair.mykey.key_name
  security_groups      = [aws_security_group.ASG.id]
  user_data            = <<EOF
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo Web01 > /var/www/html/index.html
    systemctl restart httpd
  EOF
}

resource "aws_autoscaling_group" "myasg" {
  name                      = "myasg"
  vpc_zone_identifier       = [aws_subnet.vpc01-a-public.id, aws_subnet.vpc01-b-public.id, aws_subnet.vpc01-c-public.id]
  max_size                  = 4
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  termination_policies      = ["Default"]
  force_delete              = true
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
  launch_configuration = aws_launch_configuration.mylc.name
  tag {
    key                 = "Name"
    value               = "EC2-Instances"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "myasg" {
  autoscaling_group_name = aws_autoscaling_group.myasg.id
  alb_target_group_arn   = aws_lb_target_group.mytg.arn
}

resource "aws_autoscaling_policy" "myasg-policy" {
  name                   = "myasg-policy"
  autoscaling_group_name = aws_autoscaling_group.myasg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

resource "aws_autoscaling_notification" "myasg-noti" {
  group_names = [aws_autoscaling_group.myasg.name]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.myasg-sns.arn
}