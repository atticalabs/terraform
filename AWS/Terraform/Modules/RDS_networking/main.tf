/* subnet used by rds */
resource "aws_db_subnet_group" "rds_subnet_group" {

  name        = "rds-subnet-group-${var.env_full_name}"
  description = "rds subnet group"

  subnet_ids = var.subnet_ids

  tags = {
    Environment = var.environment
  }
}

/* Security Group for resources that want to access the Database */
resource "aws_security_group" "db_access_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.env_full_name}-db-access-sg"
  description = "Allow access to RDS"

  tags = {
    Name        = "${var.env_full_name}-db-access-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.env_full_name}-rds-sg"
  description = "${var.env_full_name} Security Group"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.env_full_name}-rds-sg"
    Environment = var.environment
  }

  // allows traffic from the SG itself
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  //allow traffic for TCP 3306
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.db_access_sg.id]
  }

  //allow traffic for TCP 3306 from internet
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.cidr_for_public_access
  }

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}