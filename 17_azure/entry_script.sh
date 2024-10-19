#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
echo "<html><body><h1>Hello from Azure Task</h1></body></html>"  >  /var/www/html/index.html
sudo systemctl start apache2
sudo systemctl enable apache2