#!/bin/bash

yum install httpd -y 
systemctl start httpd
systemctl enable httpd 
echo This is Web01 Website > /var/www/html/index.html
systemctl restart httpd