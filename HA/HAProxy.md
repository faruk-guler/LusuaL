- https://www.haproxy.org/
- https://haproxy.debian.net/
- https://hub.docker.com/_/haproxy/

```sh
sudo apt update
sudo apt upgrade -y

apt show haproxy
sudo apt install haproxy=3.2.*
haproxy -v

# Conf:
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
nano /etc/haproxy/haproxy.cfg

# Validation:
sudo haproxy -c -f /etc/haproxy/haproxy.cfg

# Services:
sudo systemctl enable haproxy
sudo systemctl start haproxy
sudo systemctl status haproxy

# Syslog:
sudo systemctl status rsyslog
sudo systemctl enable --now rsyslog
```
