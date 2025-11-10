# NGINX Reverse Proxy:
Yüksek performanslı, açık kaynaklı bir web sunucusu olmasının yanı sıra, özellikle kurumsal ortamlarda çok tercih edilen güçlü ve esnek bir Reverse Proxy (Ters Vekil) sunucusudur. Olay tabanlı (event-driven), asenkron mimarisi sayesinde yüksek eşzamanlı bağlantıları düşük kaynak tüketimiyle yönetebilir.

Server and IP Plane:
```sh
http://192.168.88.135:8080 ➝ http://project1.cali.web
http://192.168.88.136:8081 ➝ http://project2.cali.web
```

## Install:
```sh
# Debian/Ubuntu
sudo apt install nginx

# RHELL
sudo dnf install epel-release -y
sudo dnf install nginx
```

## Services:
```sh
sudo systemctl enable nginx
sudo systemctl start nginx
systemctl status nginx
nginx -v  # Version
nginx -t  # Verify
```

## Conf:
| File: /etc/nginx/sites-available/farukguler.com.conf

| File: /etc/nginx/conf.d/farukguler.com.conf

```sh
server {
    listen 80;
    server_name example.com;  # Domain adınızı buraya yazın

    location / {
        proxy_pass http://localhost:3000;  # Backend uygulamanızın adresi
        proxy_http_version 1.1;
        
        # Proxy başlıkları
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Enabled:
```sh
sudo ln -s /etc/nginx/sites-available/farukguler.com.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## Firewall:
```sh
# UFW:
sudo ufw allow 'Nginx Full'
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# firewalld:
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```
## Test:
```sh
curl -I http://example.com
```

## Logs:
```sh
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```
