# Get latest Amazon Windows Server 2019 Ami
data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = module.networking.vpc_id
  ingress {
    description = "Allow inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

module "ec2_win" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name                        = "ec2-${var.project}-${var.env}"
  ami                         = data.aws_ami.windows-2022.id
  ignore_ami_changes          = false
  instance_type               = "t3a.micro"
  subnet_id                   = element(module.networking.public_subnets, 0)
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  user_data                   = file("./scripts/userdata.tpl")
  user_data_replace_on_change = true
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    AdministratorAccess          = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  metadata_options = {
    http_tokens = "required"
  }
}