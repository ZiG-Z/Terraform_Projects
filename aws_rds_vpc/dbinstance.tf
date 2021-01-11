resource "aws_db_instance" "db01" {
  allocated_storage       = 20
  engine                  = "mariadb"
  engine_version          = "10.4.8"
  instance_class          = "db.t2.micro"
  identifier              = "db01" #DB Instance Name
  name                    = "db01" #DB Name
  username                = "pmk"
  password                = var.dbpassword
  db_subnet_group_name    = aws_db_subnet_group.dbsubnet01.name
  parameter_group_name    = aws_db_parameter_group.mariadb-para.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.RDS.id]
  storage_type            = "gp2"
  backup_retention_period = 1
  availability_zone       = "ap-southeast-1b"
  tags = {
    Name = "db01"
  }
}

resource "aws_security_group" "RDS" {
  name        = "RDS"
  description = "RDS"
  vpc_id      = aws_vpc.vpc01.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.DbClient.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}