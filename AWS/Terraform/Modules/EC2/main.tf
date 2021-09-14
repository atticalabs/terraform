resource "aws_key_pair" "key" {
  key_name   = "${var.env_full_name}-key"
  public_key = file(var.ssh_key_file)
}

resource "aws_instance" "ec2" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name

  tags = {
    Name = var.instance_name
  }
}