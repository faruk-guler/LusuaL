# Istall Squid

```sh
sudo apt install squid -y
sudo systemctl start squid
sudo systemctl restart squid
sudo systemctl enable squid
sudo systemctl status squid
```

# Squid Files:
```sh
Squid Server configuration file: /etc/squid/squid.conf
Squid Client configuration file: /etc/environment 
Squid Access log: /var/log/squid/access.log
Squid Cache log: /var/log/squid/cache.log
```

# Squid Server:
>>>
```sh
# ===================================
# ACL TANIMLARI
# ===================================

# Yerel ağlar
acl localnet src 10.0.0.0/8
acl localnet src 192.168.0.0/16

# Özel amaçlı ACL'ler
acl to_localhost dst 127.0.0.0/8
acl to_linklocal dst fe80::/10

# Port tanımları
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http

# Yönetim erişimi
acl localhost src 127.0.0.1/32

# ===================================
# ERİŞİM KURALLARI (SIRALI!)
# ===================================

# 1. Yönetici erişimi (yalnızca localhost)
http_access allow localhost manager
http_access deny manager

# 2. Güvenli olmayan portlara erişimi engelle
http_access deny !Safe_ports

# 3. Sadece SSL portlarında CONNECT izni
http_access deny CONNECT !SSL_ports

# 4. Yerel ağlara izin ver (önemli: bu, 50 sunucun için)
http_access allow localnet

# 5. Loopback erişimi
http_access allow localhost

# 6. Loopback ve link-local hedeflerini engelle (güvenlik)
http_access deny to_localhost
http_access deny to_linklocal

# 7. Diğer tüm erişimleri reddet (kritik!)
http_access deny all

# ===================================
# DİĞER AYARLAR
# ===================================
http_port 3128
coredump_dir /var/spool/squid
include /etc/squid/conf.d/*.conf

# Log
access_log /var/log/squid/access.log combined
```


## Squid Client:
>>>

```sh
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
http_proxy="http://192.168.26.130:3128/"
https_proxy="http://192.168.26.130:3128/"
# ftp_proxy="http://192.168.26.130:3128/"  # Gerekirse etkinleştir
no_proxy="localhost,127.0.0.1,192.168.26.130,192.168.0.0/16,10.0.0.0/8,.local,.internal,.svc,.cluster.local"
```
