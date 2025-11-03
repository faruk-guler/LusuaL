# Corosync & Pacemaker:
Corosync ve Pacemaker, Linux tabanlı sistemlerde yüksek erişilebilirlik (High Availability - HA) sağlamak için birlikte kullanılan iki temel bileşendir.
Birlikte çalışarak sistemdeki servislerin veya uygulamaların otomatik olarak izlenmesini, yeniden başlatılmasını ve başka node’a taşınmasını (failover) sağlarlar.

- Corosync: Düğümler arasında iletişimi sağlar.
- Pacemaker: Kaynakların durumunu izler ve gerektiğinde failover işlemini gerçekleştirir.
- Pcs: Pacemaker ve Corosync kümelerini kolayca kurmak, yapılandırmak ve yönetmek için kullanılan bir yönetim aracı. (CLI + Web UI).
- Birlikte Çalışma: Corosync kümeyi "yapar", Pacemaker ise bu küme üzerinde servisleri yönetir. Standart bir HA kümesi için ikisi zorunludur.

## Server and IP Plane:
```sh
- Node 1: node1 (192.168.1.11)
- Node 2: node2 (192.168.1.12)
- Virtual IP (VIP): 192.168.1.100
- Service: Apache web sunucusu
```

## /etc/hosts
```sh
# /etc/hosts (all nodes)
192.168.1.11 node1
192.168.1.12 node2
```

## Install:
```sh
# CentOS/RHEL
yum install pacemaker corosync pcs -y

# Debian/Ubuntu
apt-get install pacemaker corosync pcs -y
```

## Services:
```sh
sudo systemctl enable pcsd
sudo systemctl start pcsd
```

# Create User and Auth:
```sh
sudo passwd hacluster
pcs host auth Node1 Node2 -u hacluster -p <yourpasss>
pcs cluster auth node1 node2 -u hacluster -p şifre
```

## Create Cluster:
```sh
pcs cluster setup --name ha_cluster node1 node
pcs cluster start --all
pcs cluster enable --all
```

## Corosync Conf:
File: /etc/corosync/corosync.conf
```sh
------
---
-----
```


## Status:
```sh
pcs status
pcs resource status
pcs resource show
pcs status nodes
pcs status cluster
```

# Firewall:
```sh
sudo ufw allow from 192.168.1.0/24 to any port 5404,5405 proto udp
sudo ufw allow from 192.168.1.0/24 to any port 3121,21064 proto tcp
```

# Logs:
```sh
# Corosync
sudo journalctl -u corosync -f

# Pacemaker
sudo journalctl -u pacemaker -f

# PCS
sudo tail -f /var/log/pacemaker/pacemaker.lo
```











