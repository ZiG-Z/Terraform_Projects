resource "aws_lb" "myalb" {
  name                       = "myalb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.myalb.id]
  subnets                    = [aws_subnet.vpc01-a-public.id, aws_subnet.vpc01-b-public.id, aws_subnet.vpc01-c-public.id]
  enable_deletion_protection = false
  tags = {
    Environment = "Production"
  }
  timeouts {
    create = "3m"
    update = "3m"
    delete = "3m"
  }
}

resource "aws_lb_listener" "myalb" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}

resource "aws_lb_target_group" "mytg" {
  name                          = "mytg"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.vpc01.id
  deregistration_delay          = 60
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance"
  health_check {
    enabled             = true
    interval            = 30
    path                = "/index.html"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "mytg" {
  target_group_arn  = aws_lb_target_group.mytg.arn
  target_id         = aws_instance.Web01.id
  port              = 80
}

resource "aws_lb_target_group_attachment" "mytg1" {
  target_group_arn  = aws_lb_target_group.mytg.arn
  target_id         = aws_instance.Web02.id
  port              = 80
}