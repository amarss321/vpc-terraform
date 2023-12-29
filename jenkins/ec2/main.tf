resource "aws_instance" "jenkins-server" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
   user_data = var.user_data_install_jenkins
  tags = {
    "Name" = "jenkins-server"
  }
}