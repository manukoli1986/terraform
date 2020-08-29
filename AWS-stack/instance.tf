#Creating new EC2 in new vpc with new subnets
resource "aws_instance" "node" {
  ami = "ami-0b69ea66ff7391e80"
  instance_type = "t2.small"
  key_name = "${var.key_name}"
  subnet_id   = "${aws_subnet.public_subnet.id}"
  network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index         = 0
  }
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  associate_public_ip_address = true
  tags = {
    Name= "Node1"
    Env = "dev"
  }
  provisioner "file" {
    source = "./httpd.sh"
    destination  = "/tmp/httpd.sh"
    connection {
      type     = "ssh"
      host     = "${self.public_ip}"
      user     = "${var.user}"
      private_key = "${file(var.aws_existed_key_name)}"
      timeout  = "5m"
    }
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "${self.public_ip}"
      user     = "${var.user}"
      private_key = "${file(var.aws_existed_key_name)}"
      timeout  = "5m"
    }
    inline = [
      "sudo sh +x /tmp/httpd.sh"
    ]
  }
}


