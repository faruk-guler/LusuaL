# Linux fstab Dosyası: Ayrıntılı Kılavuz ve Kullanım Örnekleri

## Giriş
Linux işletim sistemlerinde disk bölümlerinin otomatik olarak bağlanmasını sağlayan **fstab** (File Systems Table) dosyası, sistem başlangıcında hangi dosya sistemlerinin nasıl bağlanacağını belirten kritik bir yapılandırma dosyasıdır. Bu makalede **fstab** dosyasının yapısını, kullanım seçeneklerini ve çeşitli senaryolardaki önemini detaylı bir şekilde inceleyeceğiz.

---

## 1. fstab Nedir?
`/etc/fstab`, Linux sistemlerinde disk bölümlerini, ağ dosya sistemlerini ve diğer aygıtları otomatik olarak bağlamak için kullanılan bir yapılandırma dosyasıdır. Sistem önyükleme sırasında **mount** komutu tarafından işlenir ve belirtilen tüm dosya sistemleri, burada tanımlanan seçeneklere göre bağlanır.

---

## 2. fstab Dosyasının Yapısı ve Formatı
`/etc/fstab` dosyasında her satır, aşağıdaki formatı takip eder:

```plaintext
<dosya_sistemi>  <bağlama_noktası>  <tip>  <seçenekler>  <dump>  <pass>
```

Her alanın anlamı şunlardır:

1. **Dosya Sistemi (File System)**: Bağlanacak disk bölümü (örneğin: `/dev/sda1`, UUID veya LABEL kullanılabilir).
2. **Bağlama Noktası (Mount Point)**: Dosya sisteminin sisteme bağlanacağı konum (örneğin: `/mnt/data`).
3. **Tip (Type)**: Dosya sisteminin türü (örneğin: `ext4`, `xfs`, `nfs`).
4. **Seçenekler (Options)**: Bağlama işlemi için kullanılan parametreler (örneğin: `defaults`, `ro`, `rw`, `noexec`, `nosuid`).
5. **Dump (Backup Flag)**: `dump` yedekleme aracı için ayar (0: yedekleme yapılmaz, 1: yedekleme yapılır).
6. **Pass (Filesystem Check Order)**: `fsck` tarafından dosya sistemini kontrol etme sırası (0: kontrol edilmez, 1: root dosya sistemi, 2: diğerleri).

---

## 3. fstab Alanları ve Seçenekler

### **Dosya Sistemi Tanımlama (Disk Bölümleri, UUID ve LABEL)**
Disk bölümleri **/dev/sdX** gibi tanımlanabileceği gibi, **UUID** veya **LABEL** kullanılarak da belirtilebilir:

- **UUID Kullanımı:**
  ```plaintext
  UUID=1234abcd-5678-efgh-9101-ijklmnopqrst /mnt/data ext4 defaults 0 2
  ```
- **LABEL Kullanımı:**
  ```plaintext
  LABEL=mydisk /mnt/data ext4 defaults 0 2
  ```

### **fstab İçin Yaygın Kullanılan Seçenekler**

- `defaults` → (`rw, suid, dev, exec, auto, nouser, async`) öntanımlı seçenekleri içerir.
- `noauto` → Sistem açılışında bağlamaz, manuel bağlanması gerekir.
- `ro` → Yalnızca okunabilir bağlar.
- `rw` → Okuma-yazma erişimi sağlar.
- `noexec` → Çalıştırılabilir dosyaları çalıştırmayı engeller.
- `nosuid` → SetUID ve SetGID izinlerini devre dışı bırakır.
- `nodev` → Aygıt dosyalarını devre dışı bırakır.

---

## 4. fstab ile Bağlama Seçenekleri
Aşağıdaki örneklerde farklı bağlama seçenekleri ile **fstab** kullanımını görebiliriz.

### **Temel ext4 Bölümü Ekleme**
```plaintext
/dev/sda1  /data  ext4  defaults  0  2
```

### **Read-Only (Salt Okunur) Bölüm Tanımlama**
```plaintext
/dev/sdb1  /mnt/backup  ext4  ro  0  2
```

### **tmpfs ile RAM Disk Tanımlama**
```plaintext
tmpfs  /mnt/ramdisk  tmpfs  defaults,size=1G  0  0
```

---

## 5. fstab Hatalarını Önleme ve Test Etme
**fstab** dosyasını düzenledikten sonra hata olup olmadığını kontrol etmek için şu komutlar kullanılabilir:

1. **fstab Yapılandırmasını Test Etme:**
   ```sh
   sudo mount -a
   ```
   Bu komut, **fstab** içindeki tüm bağlamaları test eder. Eğer hata varsa terminalde görüntülenir.

2. **Bağlı Dosya Sistemlerini Kontrol Etme:**
   ```sh
   cat /proc/mounts
   ```
   veya
   ```sh
   mount | column -t
   ```

3. **fsck ile Dosya Sistemini Kontrol Etme:**
   ```sh
   sudo fsck -y /dev/sda1
   ```
   `fsck` komutu, dosya sistemindeki hataları düzeltmek için kullanılır.

---

## 6. Örnek fstab Konfigürasyonları

### **Standart Bir fstab Dosyası Örneği**
```plaintext
# /etc/fstab: statik dosya sistem bilgisi
#
# <dosya_sistemi>  <bağlama_noktası>  <tip>  <seçenekler>  <dump>  <pass>
UUID=1234abcd-5678-efgh-9101-ijklmnopqrst  /  ext4  defaults  0  1
UUID=5678abcd-1234-ijkl-9101-mnopqrstuvwx  /home  ext4  defaults  0  2
UUID=abcd1234-5678-ijkl-9101-qrstuvwxmnop  swap  swap  defaults  0  0
```

---

## Sonuç
**fstab**, Linux sistemlerinde dosya sistemlerini otomatik olarak bağlamak için kritik bir yapılandırma dosyasıdır. Yanlış yapılandırmalar sistemin açılmasını engelleyebilir, bu yüzden dikkatli düzenlenmelidir. `mount -a` ve `fsck` gibi araçlarla yapılan değişikliklerin doğruluğu test edilmelidir. Doğru yapılandırılmış bir **fstab** dosyası, sistem yönetimini büyük ölçüde kolaylaştırır.

---

Bu rehber, Linux kullanıcılarının **fstab** dosyasını daha iyi anlamasına ve yönetmesine yardımcı olmak amacıyla hazırlanmıştır. Daha fazla bilgi için `man fstab` komutunu çalıştırabilirsiniz.

