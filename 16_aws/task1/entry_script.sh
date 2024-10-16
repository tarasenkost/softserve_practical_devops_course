#!/bin/bash

sudo amazon-linux-extras install -y nginx1
echo "<html><body><h1>Hello from AWS Task 1</h1></body></html>"  >  /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx