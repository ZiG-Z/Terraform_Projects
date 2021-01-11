resource "aws_eip" "eip-Web01" {
  instance = aws_instance.Web01.id
  vpc      = true
}