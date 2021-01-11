resource "aws_db_parameter_group" "mariadb-para" {
  name   = "mariadb-parameter"
  family = "mariadb10.4"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
