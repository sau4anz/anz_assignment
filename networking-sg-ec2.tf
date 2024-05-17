/*
Code in this file does following:
1. SG for EC2 with ingress policy for all traffic from ALB's SG-ID
2. SG for EC2 with egress policy destined to SG-ID of server's SG policy.
3. Both Ingress and Egress security group rule created from/destined to SG-ID of ALB's SG policy, to avoid cyclic dependency.
*/

resource "aws_security_group" "anz-tasks-trfm-sg-ec2" {
  name        = "anz-tasks-trfm-sg-ec2"
  description = "SG for EC2 Server Instance"
  vpc_id      = aws_vpc.anz-tasks-trfm-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG Rule for HTTP Traffic"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Egress SG Rule allowing all traffic - Wild Entry - DeleteIt"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name"      = "anz-tasks-trfm-sg-ec2"
  }
}

# SG rule for ALB.
resource "aws_security_group_rule" "anz-tasks-trfm-sg-ec2-egr-addon" {
  security_group_id        = aws_security_group.anz-tasks-trfm-sg-alb.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  type                     = "egress"
  source_security_group_id = aws_security_group.anz-tasks-trfm-sg-ec2.id
  description = "Egress addon SG Rule forwarding all traffic to ALB SG"
}
resource "aws_security_group_rule" "anz-tasks-trfm-sg-ec2-ingr-addon" {
  security_group_id        = aws_security_group.anz-tasks-trfm-sg-alb.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  type                     = "ingress"
  source_security_group_id = aws_security_group.anz-tasks-trfm-sg-ec2.id
  description = "Ingress SG Rule recieving all traffic from ALB SG"
}

output "aws_security_group_ec2id_output" {
  description = "SG ID for EC2 Server"
  value       = aws_security_group.anz-tasks-trfm-sg-ec2.id
}