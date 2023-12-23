data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# Create EC2 Instance - Amazon Linux
resource "aws_instance" "jenkins-server" {
  depends_on             = [aws_security_group.ec2_sg_ssh_http, aws_security_group.ec2_jenkins_port_8080]
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  instance_type          = "t2.medium"
  key_name               = "terraform"
  user_data              = file("jenkins.sh")
  vpc_security_group_ids = [aws_security_group.ec2_jenkins_port_8080.id, aws_security_group.ec2_sg_ssh_http.id]
  tags = {
    "Name" = "jenkins-server"
  }
}