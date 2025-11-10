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

| File: /etc/nginx/conf.d/
```sh
server {
    listen 80;

    server_name example.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
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
