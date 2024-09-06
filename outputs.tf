output "win_id" {
  value = module.ec2_win.id
}

output "win_public_ip" {
  value = module.ec2_win.public_ip
}

output "ssm_command_win_pwd_reset" {
  value = "aws ssm start-session --target ${module.ec2_win.id} --document-name 'AWS-PasswordReset' --parameters username='Administrator' --region ${local.aws_region} --profile SET-AWS-PROFILE"
}

output "ssm_command_win_port_forward" {
  value = "aws ssm start-session --target ${module.ec2_win.id} --document-name 'AWS-StartPortForwardingSession' --parameters portNumber='3389',localPortNumber='53389' --region ${local.aws_region} --profile SET-AWS-PROFILE"
}

output "rdp_win_fqdn" {
  value = "localhost:53389"
}
output "rdp_win_user" {
  value = "Administrator"
}