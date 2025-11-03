# Keepalived: 
Yüksek erişilebilirlik (high availability) ve yük dengeleme (load balancing) sağlamak amacıyla kullanılan açık kaynaklı bir yazılımdır.
Özellikle Linux sistemlerinde yaygın olarak kullanılır ve VRRP (Virtual Router Redundancy Protocol) protokolünü uygulayarak,
yüksek erişilebilirlik sağlayan sanal IP (VIP) adreslerinin otomatik olarak bir sunucudan diğerine devretmesini (failover) sağlar.

## Server and IP Plane:
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
-Debian / Ubuntu:
sudo apt update
sudo apt install keepalived
sudo keepalived --version

-RHEL:
sudo dnf install epel-release -y
sudo dnf install keepalived -y
```

## Services:
```sh
sudo systemctl enable keepalived
sudo systemctl start keepalived
sudo systemctl stop keepalived
sudo systemctl status keepalived
sudo journalctl -u keepalived -f
```
## Conf: [Master]
file: /etc/keepalived/keepalived.conf
```sh
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.1.100/24
    }
}
```

## Conf: [Backup]
file: /etc/keepalived/keepalived.conf
```sh
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 90
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.1.100/24
    }
}
```

## Firewall:
```sh
sudo ufw allow 112
```

## Notification Scripts:
File: /etc/keepalived/scripts/notify_master.sh
```sh
-------------
-------------
-------------
```

## Logs:
```sh
sudo journalctl -u keepalived -f
sudo journalctl -u keepalived -n 100
tail -f /var/log/keepalived-state.log
```



