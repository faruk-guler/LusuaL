# NGINX Reverse Proxy:
Yüksek performanslı, açık kaynaklı bir web sunucusu olmasının yanı sıra, özellikle kurumsal ortamlarda çok tercih edilen güçlü ve esnek bir Reverse Proxy (Ters Vekil) sunucusudur. Olay tabanlı (event-driven), asenkron mimarisi sayesinde yüksek eşzamanlı bağlantıları düşük kaynak tüketimiyle yönetebilir.

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
File: nano /etc/nginx/sites-available/app.farukguler.com
File: /etc/nginx/conf.d/
```sh
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
