resource "aws_key_pair" "participant-key" {
  key_name = "isucon_key"
  public_key = file("./modules/credential/isucon_id_ed25519.pub")
}

resource "aws_instance" "participant-instance" {
  ami = var.standalone_ami_id
  count = length(var.ec2_members)
  instance_type = var.ec2_instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = aws_key_pair.participant-key.id
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_type = "standard"
    volume_size = var.ec2_volume_size
    delete_on_termination = true
  }

  tags = {
    Name = format("isucon-%s", lookup(var.ec2_members, count.index))
  }
}

resource "aws_eip" "participant-eip" {
  count = length(var.ec2_members)
  instance = aws_instance.participant-instance[count.index].id
}
