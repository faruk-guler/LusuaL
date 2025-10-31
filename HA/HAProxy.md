# HAProxy:
HAProxy, açılımı High Availability Proxy olan, açık kaynaklı bir yük dengeleyici (load balancer) ve ters proxy (reverse proxy) yazılımıdır.
Özellikle web sunucuları, API servisleri ve mikroservis mimarilerinde yüksek performans, güvenilirlik ve ölçeklenebilirlik sağlamak için kullanılır.

## Install:
```sh
sudo apt update
sudo apt upgrade -y
apt show haproxy
sudo apt install haproxy
sudo apt install haproxy=3.2.*
haproxy -v
```

## Services:
```sh
sudo systemctl enable haproxy
sudo systemctl start haproxy
sudo systemctl restart haproxy
```

## Configuration:

```sh
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
nano /etc/haproxy/haproxy.cfg
```

## Conf. File:
```sh
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon
    maxconn 2000
    user haproxy
    group haproxy
    tune.ssl.default-dh-param 2048

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5s
    timeout client  30s
    timeout server  30s
    retries 3

frontend http_front
    bind *:80
    default_backend web_backend

backend web_backend
    balance roundrobin
    option httpchk GET /
    server web1 192.168.1.101:80 check
    server web2 192.168.1.102:80 check

listen stats
    bind *:8080
    mode http
    stats enable
    stats uri /stats
    stats refresh 10s
    stats auth admin:1234
```

## SSL Activated:
```sh
#
frontend https_front
    bind *:443 ssl crt /etc/ssl/private/haproxy.pem
    default_backend http_back
#

# Convert:
cat your_cert.crt your_key.key > /etc/ssl/private/haproxy.pem
```

## HAProxy Statics GUI: [http://server_ip:8080/stats]
```sh
listen stats
    bind *:8080
    stats enable
    stats uri /stats
    stats refresh 10s
    stats auth admin:admin123
```

## Conf. Validation:
```sh
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
sudo systemctl status haproxy
```

# Syslog:
```sh
# Conf. File: /etc/rsyslog.d/49-haproxy.conf
> local0.* /var/log/haproxy.log
sudo systemctl restart rsyslog
sudo systemctl status rsyslog
sudo systemctl enable --now rsyslog
```

- https://www.haproxy.org/
- https://haproxy.debian.net/
- https://hub.docker.com/_/haproxy/
