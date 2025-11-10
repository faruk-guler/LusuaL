# NGINX Reverse Proxy:
Yüksek performanslı, açık kaynaklı bir web sunucusu olmasının yanı sıra, özellikle kurumsal ortamlarda çok tercih edilen güçlü ve esnek bir Reverse Proxy (Ters Vekil) sunucusudur. Olay tabanlı (event-driven), asenkron mimarisi sayesinde yüksek eşzamanlı bağlantıları düşük kaynak tüketimiyle yönetebilir.

Server and IP Plane:
```sh
http://192.168.88.135:8080 ➝ http://project1.cali.web
http://192.168.88.136:8081 ➝ http://project2.cali.web
```

## Install:
```sh
sudo apt update
sudo apt install nginx -y
nginx -v  # Version
```

## Services:
```sh
sudo systemctl enable nginx
sudo systemctl start nginx
systemctl status nginx
nginx -t    # Verify
```

## Conf:
| File: nano /etc/nginx/sites-available/app.farukguler.com.conf

```sh
server {
    listen 80;
    server_name farukguler.com www.farukguler.com;

    # Let's Encrypt doğrulama için
    location ^~ /.well-known/acme-challenge/ {
        root /var/www/_well-known;
    }

    # Reverse proxy
    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_connect_timeout 5s;
        proxy_send_timeout 30s;
        proxy_read_timeout 30s;
    }
}

```

## Firewall:
```sh
sudo ufw allow 'Nginx Full' # 80 and 443
```

## Logs:
```sh
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```
