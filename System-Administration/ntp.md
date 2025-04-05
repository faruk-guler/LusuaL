# NTP Kurulumu ve Yapılandırması

Bu doküman, CentOS ve Debian tabanlı sistemlerde NTP (Network Time Protocol) sunucusunun kurulum ve yapılandırma adımlarını içermektedir.

---

## CentOS için NTP Kurulumu

### 1. Sistemi Güncelleyin
```sh
sudo yum update -y
```

### 2. NTP Paketini Kurun
```sh
sudo yum install -y ntp
```

### 3. NTP Konfigürasyonunu Kontrol Edin
```sh
cat /etc/ntp.conf
```

### 4. NTP Konfigürasyonunu Düzenleyin
```sh
sudo vi /etc/ntp.conf
```

### 5. NTP Servisini Başlatın ve Etkinleştirin
```sh
sudo systemctl start ntpd
sudo systemctl enable ntpd
```

### 6. Firewall Ayarlarını Yapılandırın (Gerekliyse)
```sh
sudo firewall-cmd --list-ports | grep -i udp
sudo firewall-cmd --zone=public --add-port=123/udp --permanent
sudo firewall-cmd --reload
```

### 7. Zaman Dilimini Ayarlayın
```sh
sudo timedatectl list-timezones | grep Istanbul
sudo timedatectl set-timezone Europe/Istanbul
```

### 8. NTP Senkronizasyonunu Kontrol Edin
```sh
ntpq -p
```

### 9. NTP Durumunu Yönetme
```sh
sudo timedatectl set-ntp 0
sudo timedatectl | grep NTP
sudo timedatectl set-ntp 1
sudo timedatectl
```

---

## Debian için NTP Kurulumu

### 1. Sistemi Güncelleyin
```sh
sudo apt update && sudo apt upgrade -y
```

### 2. NTP Paketini Kurun
```sh
sudo apt install -y ntp
```

### 3. Firewall Ayarlarını Yapılandırın (Gerekliyse)
```sh
sudo ufw allow from any to any port 123 proto udp
```

### 4. NTP Servisini Başlatın ve Etkinleştirin
```sh
sudo systemctl start ntp
sudo systemctl enable ntp
```

### 5. Zaman Dilimini Ayarlayın
```sh
sudo timedatectl list-timezones | grep Istanbul
sudo timedatectl set-timezone Europe/Istanbul
```

### 6. NTP Senkronizasyonunu Kontrol Edin
```sh
ntpq -p
```

---

## Kaynaklar
- 

