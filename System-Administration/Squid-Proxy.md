# What is Squid Proxy Server?
Squid is a most popular caching and forwarding HTTP web proxy server used my wide range of companies to cache web pages from a web server to improve web server speed, reduce response times and reduce network bandwidth usage.

# Requirements:
```sh
2 network interfaces
- eth0: 192.168.1.10/24 (NAT: internet)
- eth1: 10.0.0.1/24 (Host-only: internal network)
```

# Install Squid:

```sh
sudo apt install squid -y # Debian
sudo yum install squid -y # RHELL
#sudo apt-get install apache2-utils

sudo systemctl start squid
sudo systemctl restart squid
sudo systemctl enable squid
sudo systemctl status squid
sudo squid -k parse
```

# Squid Files:
```sh
Squid Server configuration file: /etc/squid/squid.conf
Squid Client configuration file: /etc/environment
Squid Access log: /var/log/squid/access.log
Squid Cache log: /var/log/squid/cache.log
```

# Squid Server:

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


# Squid Client:

```sh
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
http_proxy="http://192.168.26.130:3128/"
https_proxy="http://192.168.26.130:3128/"
# ftp_proxy="http://192.168.26.130:3128/"  # Gerekirse etkinleştir
no_proxy="localhost,127.0.0.1,192.168.26.130,192.168.0.0/16,10.0.0.0/8,.local,.internal,.svc,.cluster.local"
```
# Logs:
```sh
sudo tail -f /var/log/squid/access.log
sudo tail -f /var/log/squid/cache.log

```

# squid.conf2 [Squid Server Extra Conf.]
```sh
# General

http_port 3128
visible_hostname Proxy
forwarded_for delete
via off

# Log

logformat squid %tg.%03tu %6tr %>a %Ss/%03>Hs %<st %rm %ru %[un %Sh/%<a %mt
access_log /var/log/squid/access.log squid
access_log none all

# Cache

#cache_dir aufs /var/cache/squid 1024 16 256
cache_dir null /tmp
coredump_dir /var/spool/squid
cache deny all

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320

# Network ACL

acl localnet src 10.0.0.0/8     # RFC 1918 possible internal network
acl localnet src 172.16.0.0/12  # RFC 1918 possible internal network
#acl localnet src 192.168.0.0/16 # RFC 1918 possible internal network
acl localnet src fc00::/7       # RFC 4193 local private network range
acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

# Port ACL

acl SSL_ports port 443          # https
acl SSL_ports port 563          # snews
acl SSL_ports port 873          # rync
acl SSL_ports port 8090         # cp
acl Safe_ports port 80 8080     # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443 563     # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl purge method PURGE
acl CONNECT method CONNECT

# Authentication
#   Uncomment the following lines to enable file based authentication BUT:
#   The following section requires to have squid libs installed, especially `nsca_auth`, to be working.
#   This sections uses a Htpasswd file named `users.pwd` file to store eligible accounts.
#   You can generate yours using the htpasswd command from "apache2-utils" aptitude package, using "-d" flag to use system CRYPT.

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/users.pwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on

acl Users proxy_auth REQUIRED
http_access allow Users

# Access Restrictions

http_access allow manager localhost
http_access deny manager

http_access allow purge localhost
http_access deny purge

http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

http_reply_access allow all
htcp_access deny all
icp_access allow all
always_direct allow all

# Request Headers Forcing

request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all

# Response Headers Spoofing

reply_header_access Via deny all
reply_header_access X-Cache deny all
reply_header_access X-Cache-Lookup deny all

```
