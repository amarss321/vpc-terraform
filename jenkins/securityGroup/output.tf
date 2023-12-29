output "ec2_sg_ssh_http" {
    value = aws_security_group.ec2_sg_ssh_http.id
}
output "ec2_jenkins_port_8080" {
  value = aws_security_group.ec2_jenkins_port_8080.id
}