#!/bin/bash

apt-get update -y
apt-get install apache2 -y

systemctl start apache2
systemctl enable apache2

cat <<EOF > /var/www/html/index.html
<html>
<head>
<title>Terraform Project</title>
</head>
<body>
<h1>Hello from Terraform EC2 Server</h1>
<h2>Deployed using Terraform</h2>
</body>
</html>
EOF
