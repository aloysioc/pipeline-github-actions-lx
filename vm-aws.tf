resource "aws_instance" "ce_instance" {
  ami                         = var.ami_lnx_virg # ID da AMI do RHEL 9
  instance_type               = "t2.micro"       # Tipo de instância
  key_name                    = "CE-Mapfre"      # Nome da chave SSH
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  iam_instance_profile        = "SSM-Access" # Role de acesso
  associate_public_ip_address = true         # Habilitar IP público  

  # Instalação do agente SSM após máquina provisionada
  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y update
              sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = "CE-Mapfre-RH9"
  }
}
