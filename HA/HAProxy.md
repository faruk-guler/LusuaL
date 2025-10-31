# HAProxy:
HAProxy, short for High Availability Proxy, is an open-source load balancer and reverse proxy software. It is used primarily to provide high performance, reliability, and scalability in web servers, API services, and microservices architectures.

## Install:
```sh
sudo apt update
sudo apt upgrade -y
apt show haproxy
sudo apt install haproxy
sudo apt install haproxy=3.2.*
haproxy -v
sudo journalctl -u haproxy -f
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
# Load Balancing Algorithms:
```sh
# Round Robin (default)
balance roundrobin

# Least Connection (to the server with the fewest connections)
balance leastconn

# Source IP Hash (requests from the same IP to the same server)
balance source

# URI Hash (same URLs to the same server)
balance uri

# Header Hash (based on a specific HTTP header)
balance hdr(User-Agent)
```

## Conf. File: [balance roundrobin]
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

## SSL Termination:
```sh
#>
frontend https_front
    bind *:443 ssl crt /etc/ssl/private/haproxy.pem
    default_backend http_back
#<

# Convert & Perm:
cat your_cert.crt your_key.key > /etc/ssl/private/haproxy.pem
chmod 600 /etc/ssl/private/example.com.pem
```

## HAProxy Statics GUI: [http://server_ip:8480/stats]
```sh
listen stats
    bind *:8404
    stats enable
    stats uri /
    stats refresh 10s
    stats admin if TRUE
    stats auth admin:parola123
```

## Conf. Validation:
```sh
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
sudo systemctl status haproxy
```

## Firewall:
```sh
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=8404/tcp
sudo firewall-cmd --reload

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
sudo ufw reload
```

# Syslog:
## Conf. File: /etc/rsyslog.d/49-haproxy.conf
```sh
> local0.* /var/log/haproxy.log
sudo systemctl enable --now rsyslog
sudo systemctl restart rsyslog
sudo systemctl status rsyslog
tail -f /var/log/haproxy.log
grep "503" /var/log/haproxy.log
```
```sh
        +-----------------+
Client →|   HAProxy LB    |→ Server 1 (192.168.1.101)
        | (Frontend:80)   |→ Server 2 (192.168.1.102)
        +-----------------+
```

- https://www.haproxy.org/
- https://haproxy.debian.net/
- https://hub.docker.com/_/haproxy/
