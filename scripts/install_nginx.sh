#!/bin/bash

set -e

doas apk update
doas apk add  Nginx
doas rc-update add Nginx
doas rc-service nginx start


doas tee /etc/nginx/http.d/default.conf > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name _;

    root /var/www/localhost/htdocs;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
  <title>Mathieu - Eval OpenStack</title>
</head>
<body style="font-family:Arial;text-align:center;margin-top:20%;">
  <h1>Mathieu</h1>
    <p>Évaluation OpenStack</p>
</body>
</html>

doas tee /var/www/localhost/htdocs/index.html > /dev/null <<EOF
EOF


doas rc-service nginx restart

echo "Installation Nginx"

