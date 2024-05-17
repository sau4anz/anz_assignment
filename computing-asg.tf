/*
Code in this file does following:
1. Data type to get AMIID for instance
2. Launch Configuration
3. AutoScaling group, with MIN, MAX and DESIRED count as variable.
*/

# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_configuration" "anz-tasks-trfm-ec2-lnchcfg" {
  image_id                    = data.aws_ami.amzlinux.id
  security_groups             = [aws_security_group.anz-tasks-trfm-sg-ec2.id]
  user_data                   = file("apache-install.sh")
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "anz-tasks-trfm-ec2-asg" {
  name                 = "anz-tasks-trfm-ec2-asg"
  vpc_zone_identifier  = [aws_subnet.anz-tasks-trfm-subnet1-pub.id]
  launch_configuration = aws_launch_configuration.anz-tasks-trfm-ec2-lnchcfg.name

  desired_capacity = var.anz-tasks-trfm-ec2-asg-desired_capacity
  min_size         = var.anz-tasks-trfm-ec2-asg-min_size
  max_size         = var.anz-tasks-trfm-ec2-asg-max_size

  health_check_grace_period = 300
  health_check_type         = "EC2"

  #code to have ASG part of ALB
  target_group_arns = ["${aws_lb_target_group.anz-tasks-trfm-targetgroup.arn}"]
}