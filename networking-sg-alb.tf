/*
Code in this file does following:
1. SG for ALB with ingress policy on port 80 from internet
2. SG for ALB with egress policy destined to SG-ID of server's SG policy.
3. Egress security group rule created destined to SG-ID of server's SG policy, to avoid cyclic dependency.
*/

# Configure Security Group for ALB
resource "aws_security_group" "anz-tasks-trfm-sg-alb" {
  name        = "anz-tasks-trfm-sg-alb"
  description = "SG for ALB"
  vpc_id      = aws_vpc.anz-tasks-trfm-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG Rule for HTTP Traffic"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
}

resource "aws_security_group_rule" "anz-tasks-trfm-sg-alb-egr-addon" {
  security_group_id        = aws_security_group.anz-tasks-trfm-sg-ec2.id
  from_port                = 0
  to_port                  = 80
  protocol                 = "TCP"
  type                     = "egress"
  source_security_group_id = aws_security_group.anz-tasks-trfm-sg-alb.id
  description = "Egress SG Rule forwarding all traffic to EC2 SG"
}



#respective output of created SG
output "aws_security_group_albid_output" {
  description = "SG ID for ALB"
  value       = aws_security_group.anz-tasks-trfm-sg-alb.id
}
