# 🚀 BusyBox Nedir?

BusyBox, Linux sistemleri için geliştirilmiş, çok sayıda standart Unix aracını tek bir küçük çalıştırılabilir dosya içinde toplayan açık kaynaklı bir yazılımdır. Yaklaşık **300'den fazla** yaygın Unix komutunu kapsar ve son derece hafif bir yapıya sahiptir (genellikle 1-2 MB civarında).

**"Swiss Army Knife of Embedded Linux"** (Gömülü Linux'un İsviçre Çakısı) olarak bilinen BusyBox, Bruce Perens tarafından 1996 yılında Debian yükleyicisi için geliştirilmeye başlanmış ve günümüzde Denys Vlasenko liderliğinde aktif olarak sürdürülmektedir.

## 🎯 Kullanım Alanları

- **Gömülü Sistemler**: Yönlendiriciler, IoT cihazları, akıllı TV'ler
- **Container'lar**: Docker ve Kubernetes ortamları (Alpine Linux imajları)
- **Kurtarma Sistemleri**: LiveCD'ler ve rescue diskler
- **Minimal Linux Dağıtımları**: Alpine Linux, OpenWrt
- **Initramfs/Initrd**: Sistem başlatma süreçleri

---

## 🔧 Kurulum

BusyBox, birçok Linux dağıtımında varsayılan olarak gelir veya paket yöneticisi aracılığıyla kolayca kurulabilir.

### Debian/Ubuntu
```bash
sudo apt update
sudo apt install busybox
```

### CentOS/RHEL
```bash
sudo yum install busybox
```

### Fedora
```bash
sudo dnf install busybox
```

### Arch Linux
```bash
sudo pacman -S busybox
```

### Alpine Linux
Alpine Linux'ta BusyBox varsayılan olarak yüklüdür ve temel sistem komutlarının çoğu BusyBox üzerinden sağlanır.
Alpine'ın tüm sistemi BusyBox tabanlıdır.
```bash
apk add busybox  # Güncelleme için
```

### Kaynak Koddan Derleme
```bash
# Kaynak kodu indirin
wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar xjf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

# Yapılandırma (menuconfig ile özelleştirilebilir)
make defconfig  # Varsayılan yapılandırma
# veya
make menuconfig  # Özelleştirilmiş yapılandırma

# Derleme
make

# Kurulum
sudo make install
```

---

## 📚 Temel Kullanım

### Komut Listeleme ve Version
BusyBox içindeki tüm mevcut applet'ları (komutları) listeler:
```bash
busybox | head -1
busybox --list
```

Çıktı formatını değiştirmek için:
```bash
busybox --list-full  # Tam yollarla listele
```

### BusyBox Üzerinden Komut Çalıştırma
BusyBox'ı açıkça belirterek komut çalıştırabilirsiniz:
```bash
busybox ls -la
busybox grep "pattern" file.txt
busybox find /path -name "*.txt"
busybox wget https://example.com/file.zip
```

### Sembolik Linkler ile Kullanım
BusyBox genellikle sembolik linkler aracılığıyla kullanılır. Kurulum sırasında her applet için sembolik link oluşturulur:
```bash
# Sembolik linkleri oluşturma
busybox --install -s

# Örnek: ls komutu aslında busybox'a bir link olabilir
ls -la  # /bin/ls -> /bin/busybox
```

### BusyBox Shell Kullanımı
BusyBox kendi hafif shell'ini (ash - Almquist Shell) içerir:
```bash
busybox sh
```

veya doğrudan:
```bash
/bin/busybox ash
```

---

## 🔍 Applet Kavramı

BusyBox'ta **applet**, tek bir işlevi gerçekleştiren bağımsız bir komut/araç anlamına gelir. Her applet, BusyBox binary dosyası içinde gömülü olarak bulunur ve sembolik linkler veya doğrudan çağrı ile erişilir.

### Applet Örnekleri
- **Dosya İşlemleri**: ls, cp, mv, rm, mkdir, touch
- **Metin İşleme**: cat, grep, sed, awk, cut, sort
- **Ağ Araçları**: wget, ping, telnet, nc (netcat), ifconfig
- **Sistem Araçları**: ps, top, kill, mount, umount, df
- **Arşivleme**: tar, gzip, gunzip, unzip

### Belirli Bir Applet Hakkında Yardım
```bash
busybox ls --help
busybox grep --help
busybox tar --help
```

---

## ⚙️ Yapılandırma ve Özelleştirme

BusyBox, derleme zamanında ihtiyaçlarınıza göre özelleştirilebilir. Bu sayede yalnızca gereken applet'ları dahil ederek boyutunu daha da küçültebilirsiniz.

### Menuconfig ile Yapılandırma
```bash
cd busybox-source
make menuconfig
```

Bu komut, Linux kernel yapılandırmasına benzer bir arayüz açar ve şunları yapmanızı sağlar:
- İstediğiniz applet'ları seçme/kaldırma
- Özellik seviyelerini ayarlama (tam/minimal)
- Derleme seçeneklerini belirleme

### Statik Binary Oluşturma
Bağımlılıksız, taşınabilir bir binary oluşturmak için:
```bash
make LDFLAGS=-static
```

---

## 💡 Pratik Kullanım Senaryoları

### Docker Container'da Minimal İmaj
```dockerfile
FROM busybox:latest
COPY myapp /usr/local/bin/
CMD ["/usr/local/bin/myapp"]
```

### Kurtarma Modu Script'i
```bash
#!/bin/busybox sh
# Minimal shell ile sistem kurtarma

busybox mount -t proc proc /proc
busybox mount -t sysfs sys /sys
busybox echo "Rescue mode active"
```

### Ağ Testi
```bash
busybox ping -c 4 8.8.8.8
busybox wget -O- http://example.com
busybox nc -l -p 8080  # Basit TCP sunucusu
```

---

## 🆚 Standart Araçlarla Karşılaştırma

| Özellik | GNU Coreutils | BusyBox |
|---------|---------------|---------|
| Boyut | ~14 MB | ~1-2 MB |
| Applet Sayısı | ~100 | ~300+ |
| Özellik Zenginliği | Tam | Temel/Yeterli |
| Kullanım Alanı | Masaüstü/Sunucu | Gömülü/Container |
| Bellek Kullanımı | Yüksek | Düşük |

---

## 🔐 Güvenlik Notları

- BusyBox, minimal olması nedeniyle bazı güvenlik özelliklerini içermeyebilir
- Üretim ortamlarında güncel versiyonları kullanın
- CVE (Common Vulnerabilities and Exposures) takibi yapın
- Kritik sistemlerde tam özellikli araçları tercih edebilirsiniz

---

## 📖 Ek Kaynaklar

- **Resmi Web Sitesi**: https://busybox.net/
- **Kaynak Kodu**: https://git.busybox.net/busybox/
- **Dokümantasyon**: https://busybox.net/documentation.html
- **Mailing List**: busybox@busybox.net

---

## 🎓 Sonuç

BusyBox, kaynak kısıtlı ortamlarda vazgeçilmez bir araçtır. Tek bir binary içinde yüzlerce komutu barındırması, onu gömülü sistemler, container'lar ve minimal Linux dağıtımları için ideal hale getirir. Kullanımı, sisteminizdeki BusyBox versiyonuna ve derleme zamanındaki yapılandırmaya bağlı olarak değişiklik gösterebilir.

**Not**: BusyBox komutları, GNU karşılıklarına göre daha az seçenek ve özellik içerebilir. Detaylı kullanım için her zaman `busybox <komut> --help` ile yardım alabilirsiniz.
