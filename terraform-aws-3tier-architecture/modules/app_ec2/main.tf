resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = false   # ⭐ PRIVATE SERVER

  tags = {
    Name = "App-Server"
  }

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx php-fpm php-mysql mysql-client

systemctl enable nginx
systemctl start nginx
systemctl enable php8.3-fpm
systemctl start php8.3-fpm

cat > /etc/nginx/sites-available/default <<'NGINX'
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.php;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
NGINX

cat > /var/www/html/submit.php <<PHP
<?php
\$conn = new mysqli("${var.db_endpoint}","admin","Admin1234","userdb");

if (\$conn->connect_error) { die("DB Failed"); }

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

output "private_ip" {
  value = aws_instance.app.private_ip
}