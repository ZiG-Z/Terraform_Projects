resource "aws_db_subnet_group" "dbsubnet01" {
  name       = "dbsubnet01"
  subnet_ids = [aws_subnet.vpc01-b-private.id, aws_subnet.vpc01-c-private.id]

  tags = {
    "Name" = "dbsubnet01"
  }
}