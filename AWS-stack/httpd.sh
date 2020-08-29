#!/bin/bash

sudo yum install -y httpd
sudo service httpd start
sudo chkconfig httpd on
sudo echo "<h1>Its working</h1>" > /var/www/html/index.html
sudo echo "<h1>EC2 launched by code - Me</h1>" >> /var/www/html/index.html

#END
