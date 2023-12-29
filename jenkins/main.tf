module "vpc" {
  source             = "./vpc"
  name               = var.name
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
}

module "SG" {
  source              = "./securityGroup"
  ec2_sg_name         = var.ec2_sg_name
  ec2_jenkins_sg_name = var.ec2_jenkins_sg_name
  vpc_id              = module.vpc.vpc_id
}

module "EC2" {
  source                    = "./ec2"
  public_subnet_id          = tolist(module.vpc.private_subnets)[0]
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_security_group_ids    = [module.SG.ec2_sg_ssh_http, module.SG.ec2_jenkins_port_8080]
  user_data_install_jenkins = templatefile("./jenkins.sh", {})
}
module "TRG" {
  source                   = "./load-balancer-TR"
  lb_target_group_name     = "jenkins-lb-target-group"
  lb_target_group_port     = 8080
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.vpc.vpc_id
  ec2_instance_id          = module.EC2.jenkins_public_ip
}

module "applicationLB" {
  source                          = "./applictionloadbalancer"
  lb_name                         = "dev-proj-1-alb"
  lb_type                         = "application"
  is_external                     = false
  sg_enable_ssh_https             = module.SG.ec2_sg_ssh_http
  subnet_ids                      = tolist(module.vpc.public_subnets)
  tag_name                        = "dev-proj-1-alb"
  lb_target_group_arn             = module.TRG.dev_proj_1_lb_target_group_arn
  ec2_instance_id                 = module.EC2.jenkins_public_ip
  lb_listner_default_action       = "forward"
  lb_target_group_attachment_port = 8080
  lb_listner_port = 80
  lb_listner_protocol = "HTTP"
}