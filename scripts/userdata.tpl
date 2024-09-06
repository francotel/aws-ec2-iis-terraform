<powershell>
# Instala IIS y la función de seguridad de IP en el servidor
Install-WindowsFeature -name Web-Server, Web-IP-Security -IncludeManagementTools

# Obtén un token de la metadata de EC2 para usarlo en solicitudes posteriores
$token = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/api/token' -Method PUT -Headers @{'X-aws-ec2-metadata-token-ttl-seconds' = '21600'} -UseBasicParsing).Content

# Realiza las solicitudes de metadata usando el token obtenido
$instanceId   = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/instance-id' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content
$instanceAZ   = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/placement/availability-zone' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content
$pubHostName  = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/public-hostname' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content
$pubIPv4      = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/public-ipv4' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content
$privHostName = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/local-hostname' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content
$privIPv4     = (Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/local-ipv4' -Headers @{'X-aws-ec2-metadata-token' = $token} -UseBasicParsing).Content

# Crea el archivo index.html en la ruta de IIS y añade el contenido HTML con estilos mejorados
New-Item -Path C:\inetpub\wwwroot\index.html -ItemType File -Force
Add-Content -Path C:\inetpub\wwwroot\index.html "<!DOCTYPE html>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<html lang='en'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<head>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<meta charset='UTF-8'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<meta http-equiv='X-UA-Compatible' content='IE=edge'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<title>AWS Windows Server</title>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<style>"
Add-Content -Path C:\inetpub\wwwroot\index.html "body { background-color: #000000; color: white; font-family: 'Verdana'; text-align: center; }"
Add-Content -Path C:\inetpub\wwwroot\index.html "h1 { margin-top: 20px; font-size: 2.5rem; }"
Add-Content -Path C:\inetpub\wwwroot\index.html ".metadata { margin: 20px auto; width: 60%; padding: 20px; background-color: #ffffff22; border-radius: 10px; font-size: 1.1rem; }"
Add-Content -Path C:\inetpub\wwwroot\index.html ".logos { display: flex; justify-content: center; align-items: center; margin: 20px; gap: 40px; }"
Add-Content -Path C:\inetpub\wwwroot\index.html ".logos img { height: 80px; border-radius: 5px; }"
Add-Content -Path C:\inetpub\wwwroot\index.html "</style>"
Add-Content -Path C:\inetpub\wwwroot\index.html "</head>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<body>"

# Agregar el título y los logos
Add-Content -Path C:\inetpub\wwwroot\index.html "<h1>AWS Windows VM Deployed with Terraform</h1>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<div class='logos'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<img src='https://www.pngall.com/wp-content/uploads/15/Amazon-Logo-White-PNG-Image.png' alt='AWS Logo'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<img src='https://logowik.com/content/uploads/images/microsoft-iis2928.jpg' alt='IIS Logo'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "</div>"

# Agregar los datos de metadata de EC2
Add-Content -Path C:\inetpub\wwwroot\index.html "<div class='metadata'>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>Instance ID:</b> $instanceId</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>AWS Availability Zone:</b> $instanceAZ</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>Public Hostname:</b> $pubHostName</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>Public IPv4:</b> $pubIPv4</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>Private Hostname:</b> $privHostName</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "<p><b>Private IPv4:</b> $privIPv4</p>"
Add-Content -Path C:\inetpub\wwwroot\index.html "</div>"

# Cerrar el cuerpo y el HTML
Add-Content -Path C:\inetpub\wwwroot\index.html "</body>"
Add-Content -Path C:\inetpub\wwwroot\index.html "</html>"

</powershell>

