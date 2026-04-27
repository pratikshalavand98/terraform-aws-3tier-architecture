############################################
# LOCALS – USER DATA SCRIPTS
############################################
locals {

  ######################## WEB SERVER ########################
  web_userdata = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx

systemctl enable nginx
systemctl start nginx

rm -f /var/www/html/index.nginx-debian.html

# Reverse proxy config (Web -> App)
cat > /etc/nginx/sites-available/default <<NGINX
server {
    listen 80;
    server_name _;

    location / {
        root /var/www/html;
        index index.html;
    }

    location /submit.php {
        proxy_pass http://${module.app_ec2.private_ip};
    }
}
NGINX

# HTML FORM
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

  ######################## APP SERVER ########################
  app_userdata = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx php-fpm php-mysql mysql-client

systemctl enable nginx
systemctl start nginx
systemctl enable php8.3-fpm
systemctl start php8.3-fpm

# PHP ENABLE NGINX
cat > /etc/nginx/sites-available/default <<NGINX
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.php;

    location ~ \\.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
NGINX

# PHP FILE
cat > /var/www/html/submit.php <<PHP
<?php
\$conn = new mysqli(
"${module.rds.db_endpoint}",
"admin",
"Admin1234",
"userdb"
);

if (\$conn->connect_error) {
    die("DB Connection Failed");
}

\$name=\$_POST['name'];
\$email=\$_POST['email'];

\$conn->query("CREATE TABLE IF NOT EXISTS users(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50)
)");

\$conn->query("INSERT INTO users(name,email) VALUES('\$name','\$email')");
echo "<h1>Data Saved Successfully 🎉</h1>";
?>
PHP

chmod -R 777 /var/www/html
systemctl restart nginx
systemctl restart php8.3-fpm
EOF
}

############################################
# MODULE CALLS
############################################

module "vpc" {
  source = "./modules/vpc"
}

module "web_ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.web_sg_id
  instance_name = "Web-Server"
  user_data     = local.web_userdata
}

module "app_ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnet1_id
  sg_id         = module.vpc.app_sg_id
  instance_name = "App-Server"
  user_data     = local.app_userdata
}

module "rds" {
  source          = "./modules/rds"
  private_subnet1 = module.vpc.private_subnet1_id
  private_subnet2 = module.vpc.private_subnet2_id
  db_sg           = module.vpc.db_sg_id
}