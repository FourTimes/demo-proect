resource "aws_security_group" "allow_mysql" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.production-vpc.id
  ingress {
      description = "TLS from VPC"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      # ipv6_cidr_blocks = ["::/0"]
    }
  tags = {
    Name = "allow_tls"
  }
}


module "db" {
  source     = "./module/rds-database"
  identifier = "demo"

  # Engine status
  engine               = "mysql"
  engine_version       = "8.0.25"
  instance_class       = "db.t3.large"
  allocated_storage    = 5
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group

  # credentials information
  name     = "demo"
  username = "demo"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  # Disble iam database authentication
  iam_database_authentication_enabled = false

  # security group
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  # tags
  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  # Final snapshot
  skip_final_snapshot = true

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
