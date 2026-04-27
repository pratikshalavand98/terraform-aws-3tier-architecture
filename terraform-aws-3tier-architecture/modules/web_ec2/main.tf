resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "Web-Server"
  }

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx

systemctl enable nginx
systemctl start nginx
rm -f /var/www/html/index.nginx-debian.html

# Reverse proxy (WEB → APP)
cat > /etc/nginx/sites-available/default <<NGINX
server {
    listen 80;
    server_name _;

    location / {
        root /var/www/html;
        index index.html;
    }

    location /submit.php {
        proxy_pass http://${var.app_private_ip};
    }
}
NGINX

# FORM PAGE
cat > /var/www/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
<title>3 Tier App</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-dark d-flex justify-content-center align-items-center vh-100">
<div class="card p-4" style="width:380px;">
<h3 class="text-center">User Registration</h3>

<form action="/submit.php" method="POST">
<input class="form-control mb-3" name="name" placeholder="Name" required>
<input class="form-control mb-3" name="email" placeholder="Email" required>
<button class="btn btn-primary w-100">Submit</button>
</form>

</div>
</body>
</html>
HTML

systemctl restart nginx
EOF
}