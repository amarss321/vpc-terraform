output "jenkins_public_ip" {
  value = aws_instance.jenkins-server.id
}