# 🖥️ Linux Local Repository (Yerel Depo) Nedir?

Yerel depo (**Local Repository**), Linux sistemlerinde **internet bağlantısı olmadan** paket yönetimi yapmak için kullanılan bir yöntemdir. Sistem yöneticileri, bu yöntemi **kapalı ağlarda, güvenlik gereksinimi olan ortamlarda veya hızlı dağıtım için** tercih eder.

---

## 📌 **Yerel Depo Neden Kullanılır?**
Yerel depolar aşağıdaki durumlarda büyük avantaj sağlar:

- **İnternet erişimi kısıtlı veya hiç yoksa** (Örn: Güvenlik nedeniyle izole edilmiş sistemler)
- **Paketleri hızlı yüklemek gerekiyorsa** (Örn: Yerel ağa bağlı sistemlerde)
- **Özel veya modifiye edilmiş paketlerin dağıtılması gerekiyorsa**
- **Bağımlılık yönetimini daha kontrollü yapmak istiyorsanız**

---

## ⚡ **Yerel Repo’nun Avantajları**
✔ **Hızlı Paket Kurulumu:** Paketleri internetten indirmek yerine yerel kaynaktan yükleyerek zaman kazandırır.
✔ **Bağımlılık Yönetimi:** Gerekli tüm bağımlılıkları tek bir yerde saklayarak eksik bağımlılık hatalarını önler.
✔ **Daha Güvenli:** Hangi paketlerin yükleneceği ve güncelleneceği üzerinde tam kontrol sağlar.
✔ **Kapalı Ortamlar İçin İdeal:** İnternet erişimi olmayan sistemlerde bile paket kurulumu yapılmasını sağlar.

---

# 🏗️ Debian/Ubuntu İçin Yerel Repo (APT Kullanarak)

### **1️⃣ Paketleri İçeren Bir Dizin Oluştur**
Öncelikle, yerel depo için bir klasör oluşturup `.deb` paketlerini buraya kopyalayın:
```bash
mkdir -p /var/localrepo
cp *.deb /var/localrepo/
```

### **2️⃣ Depo Yapısını Oluştur**
Depoyu tanımlamak için `dpkg-scanpackages` komutunu kullanın:
```bash
apt install dpkg-dev  # Gerekli paketi yükleyin
cd /var/localrepo
dpkg-scanpackages . | gzip -c > Packages.gz
```

### **3️⃣ APT’ye Yerel Depoyu Tanıtın**
APT'ye yeni depoyu tanıtmak için `/etc/apt/sources.list` dosyasına şu satırı ekleyin:
```
deb [trusted=yes] file:/var/localrepo ./
```

### **4️⃣ Depoyu Güncelleyin ve Paketleri Yükleyin**
```bash
apt update
apt install <paket-adı>
```
📌 **Not:** `trusted=yes` kullanmazsanız, APT imzasız paketler için uyarı verebilir.

---

# 🏗️ RHEL/CentOS İçin Yerel Repo (YUM/DNF Kullanarak)

### **1️⃣ Depo İçin Bir Klasör Oluşturun**
```bash
mkdir -p /var/localrepo
cp *.rpm /var/localrepo/
```

### **2️⃣ Depoyu Yapılandırın**
`createrepo` komutu ile depo veritabanını oluşturun:
```bash
dnf install createrepo  # Gerekli paketi yükleyin
createrepo /var/localrepo
```

### **3️⃣ YUM/DNF’ye Depoyu Tanıtın**
Yeni bir repo dosyası oluşturun:
```bash
nano /etc/yum.repos.d/localrepo.repo
```
İçeriği şu şekilde olmalıdır:
```
[localrepo]
name=Local Repository
baseurl=file:///var/localrepo
enabled=1
gpgcheck=0
```

### **4️⃣ Depoyu Güncelleyin ve Paketleri Kurun**
```bash
dnf clean all
dnf makecache
dnf install <paket-adı>
```

---

# 🌍 **HTTP/FTP ile Merkezi Repo Kurma (Opsiyonel)**
Birden fazla sistemin ortak bir repo kullanmasını sağlamak için HTTP veya FTP üzerinden erişim sağlayabilirsiniz.

📌 **Apache ile HTTP tabanlı repo kurmak için:**
```bash
dnf install httpd
systemctl enable --now httpd
ln -s /var/localrepo /var/www/html/repo
```
Daha sonra **baseurl** olarak `http://server-ip/repo` kullanabilirsiniz.

---

# 🎯 **Sonuç**
Linux’ta yerel depo oluşturmak, sistem yöneticileri için büyük bir avantaj sağlar. **Debian/Ubuntu** için **dpkg-scanpackages**, **RHEL/CentOS** için **createrepo** kullanarak kolayca yerel bir depo kurabilir, **kapalı ağlarda veya hızlı dağıtım gereken ortamlarda** etkin bir çözüm elde edebilirsiniz. 🚀

