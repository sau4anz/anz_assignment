/*
Code in this file does following:
1. Create LB Target group, reaching to instances on port 80
2. Create HTTP Listener, listening on port 80 from internet, forwarding traffic to target group
3. Create Application Load Balancer
*/


#Target Group - aws_lb_target_group
resource "aws_lb_target_group" "anz-tasks-trfm-targetgroup" {
  name     = "anz-tasks-trfm-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.anz-tasks-trfm-vpc.id
}


#Listener - aws_lb_listener
resource "aws_lb_listener" "anz-tasks-trfm-listener-http" {
  load_balancer_arn = aws_alb.anz-tasks-trfm-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anz-tasks-trfm-targetgroup.arn
  }
}

#Load Balancer - aws_lb
resource "aws_alb" "anz-tasks-trfm-alb" {
  name               = "anz-tasks-trfm-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.anz-tasks-trfm-sg-alb.id]

  subnets = [aws_subnet.anz-tasks-trfm-subnet1-pub.id, aws_subnet.anz-tasks-trfm-subnet2-pub.id]

  tags = {
    "Name"      = "anz-tasks-trfm-alb"
  }
}