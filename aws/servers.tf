# SSH 키페어 생성
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# AWS 키페어 등록 (공개키)
resource "aws_key_pair" "deployer" {
  key_name   = "${var.ssh_key_name}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# 개인키를 로컬에 저장
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${var.ssh_key_name}.pem"
  file_permission = "0400"
}

data "aws_ami" "ubuntu_arm" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

# EC2 인스턴스 생성
resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu_arm.id
  instance_type          = "t4g.small"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = {
    Name = "ubuntu-22-04-arm-t4g-small"
  }
  
  lifecycle {
    ignore_changes = [ami]  # AMI 변경 무시
  }
}

# ssh 접속 커맨드 테스트 출력
output "ssh_command" {
  value = "ssh -i ${var.ssh_key_name}.pem ubuntu@${aws_instance.server.public_ip}"
  description = "SSH connection command"
}