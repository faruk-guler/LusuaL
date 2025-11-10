# NGINX Reverse Proxy:
Yüksek performanslı, açık kaynaklı bir web sunucusu olmasının yanı sıra, özellikle kurumsal ortamlarda çok tercih edilen güçlü ve esnek bir Reverse Proxy (Ters Vekil) sunucusudur. Olay tabanlı (event-driven), asenkron mimarisi sayesinde yüksek eşzamanlı bağlantıları düşük kaynak tüketimiyle yönetebilir.

Server and IP Plane:
```sh
https://project1.app.gov  → NGINX (public IP) → http://192.168.90.145:8080
https://project2.app.gov  → NGINX (public IP) → http://192.168.90.146:8081
```

## Install:
```sh
# Debian/Ubuntu
sudo apt install nginx

# RHEL
sudo dnf install epel-release -y
sudo dnf install nginx
```

## Services:
```sh
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
nginx -v  # Version
nginx -t  # Verify
```

## Conf:
Debian/Ubuntu | File: /etc/nginx/sites-available/farukguler.com.conf

RHEL | File: /etc/nginx/conf.d/farukguler.com.conf (symlink gerekmez)

```sh
server {
    listen 80;
    server_name farukguler.com www.farukguler.com;
    
    location / {
        proxy_pass http://localhost:3000;  # Backend app port
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Enabled:
```sh
# sudo unlink /etc/nginx/sites-enabled/default [Unlink Default Site]
sudo ln -s /etc/nginx/sites-available/farukguler.com.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## Firewall:
```sh
# UFW:
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# firewalld:
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

## Manual SSL/TLS Import:
```sh
server {
    listen 443 ssl http2; # HTTP/2 desteği
    server_name farukguler.com www.farukguler.com;
    
    # Sertifika ve özel anahtar yolları
    ssl_certificate /etc/ssl/certs/farukguler.com.crt;
    ssl_certificate_key /etc/ssl/private/farukguler.com.key;
    
    # Modern ve güvenli SSL ayarları
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Proto https;
    }
}

# HTTP'den HTTPS'e yönlendirme
server {
    listen 80;
    server_name farukguler.com www.farukguler.com;
    return 301 https://$server_name$request_uri;
}
```

## Test:
```sh
curl -I http://farukguler.com
sudo ss -tulpn | grep nginx
ps aux | grep nginx
```

## Logs:
```sh
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
journalctl -u nginx -f
```
