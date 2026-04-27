resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet"

  subnet_ids = [
    var.private_subnet1,
    var.private_subnet2
  ]
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "userdb"
  username             = "admin"
  password             = "Admin1234"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.db_sg]
  publicly_accessible  = false
}