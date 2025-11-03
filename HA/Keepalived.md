# Keepalived: 
Yüksek erişilebilirlik (high availability) ve yük dengeleme (load balancing) sağlamak amacıyla kullanılan açık kaynaklı bir yazılımdır.
Özellikle Linux sistemlerinde yaygın olarak kullanılır ve VRRP (Virtual Router Redundancy Protocol) protokolünü uygulayarak,
yüksek erişilebilirlik sağlayan sanal IP (VIP) adreslerinin otomatik olarak bir sunucudan diğerine devretmesini (failover) sağlar.

Server and IP Plane:
```sh
- HAProxy-1 (MASTER):  192.168.1.10
- HAProxy-2 (BACKUP):  192.168.1.11
- Virtual IP (VIP):    192.168.1.100
- Backend Servers1:    192.168.1.101
- Backend Servers2:    192.168.1.102
- Backend Servers3:    192.168.1.103
```

## Install:
```sh
sudo apt install keepalived
keepalived --version
```

## Services:
```sh
sudo systemctl enable keepalived
sudo systemctl start keepalived
sudo systemctl stop keepalived
sudo systemctl status haproxy
sudo journalctl -u keepalived -f
```
## Conf: [Master and Backup Servers]
```sh
sudo nano /etc/keepalived/keepalived.conf 
```

## Logs:
```sh
sudo journalctl -u keepalived -f
sudo journalctl -u keepalived -n 100
tail -f /var/log/keepalived-state.log
```

