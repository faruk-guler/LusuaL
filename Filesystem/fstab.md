# Debian /etc/fstab Cheatsheet -farukguler.com

## İçindekiler
- [Giriş](#giriş)
- [fstab Dosyasının Yapısı](#fstab-dosyasının-yapısı)
- [Alan Tanımları](#alan-tanımları)
- [Dosya Sistemlerini Tanımlama Yöntemleri](#dosya-sistemlerini-tanımlama-yöntemleri)
- [Sık Kullanılan Dosya Sistemi Türleri](#sık-kullanılan-dosya-sistemi-türleri)
- [Montaj Seçenekleri](#montaj-seçenekleri)
- [Örnek Senaryolar ve Yapılandırmalar](#örnek-senaryolar-ve-yapılandırmalar)
- [Sorun Giderme](#sorun-giderme)
- [Yararlı Komutlar](#yararlı-komutlar)
- [En İyi Uygulamalar](#en-i̇yi-uygulamalar)
- [fstab Cheatsheet](#fstab-cheatsheet)

## Giriş

Linux işletim sistemlerinde, özellikle Debian tabanlı dağıtımlarda, `/etc/fstab` dosyası sistem yapılandırmasının en temel bileşenlerinden biridir. "File Systems Table" (Dosya Sistemleri Tablosu) olarak bilinen bu dosya, sistemdeki disklerin ve disk bölümlerinin nasıl monte edileceğini, hangi izinlerle erişileceğini ve sistem başlangıcında hangi işlemlerin gerçekleştirileceğini tanımlar.

Bu kapsamlı rehber, fstab dosyasının yapısını, kullanımını ve yapılandırma seçeneklerini derinlemesine inceleyerek sistem yöneticileri ve Linux kullanıcıları için temel bir kaynak oluşturmayı amaçlamaktadır.

## fstab Dosyasının Yapısı

fstab dosyası, her satırda bir dosya sistemi tanımı içeren düz metin yapısında bir dosyadır. Her tanım, aralarında boşluk veya sekme karakteri bulunan altı alandan oluşur:

```
<dosya sistemi>   <montaj noktası>   <tür>   <seçenekler>   <dump>   <pass>
```

Örnek bir fstab dosyası:

```
# /etc/fstab: sistem dosya sistemleri tablosu
#
# <dosya sistemi>        <montaj noktası>   <tür>    <seçenekler>             <dump>  <pass>
UUID=6a60524d-...        /                  ext4     defaults                 1       1
UUID=8e4b6d38-...        /home              ext4     defaults,noatime         0       2
/dev/sda5                swap                swap     defaults                0       0
tmpfs                    /tmp                tmpfs    size=2G,mode=1777       0       0
//192.168.1.100/veri     /mnt/paylaşım      cifs     credentials=/etc/cifs    0       0
```

`/proc` ve `/sys` gibi sanal dosya sistemlerinin fstab içinde listelenmesi gerekmez; özel seçenekler gerekmedikçe, sistem bunları otomatik olarak monte edecektir.

## Alan Tanımları

### 1. Dosya Sistemi (`<dosya sistemi>`)

Bu alan, monte edilecek depolama aygıtını tanımlar. Üç farklı tanımlama yöntemi kullanılabilir:

- **Kernel isimlendirmesi**: `/dev/sda1` gibi doğrudan aygıt yolları
- **UUID (Evrensel Benzersiz Tanımlayıcı)**: `UUID=6a60524d-061d-454a-bfd1-38989910eccd` formatında
- **Etiketler**: `LABEL=Debian` şeklinde kullanıcı tanımlı etiketler

### 2. Montaj Noktası (`<montaj noktası>`)

Dosya sisteminin monte edileceği dizini belirtir. Swap dosya sistemleri için genellikle "none" değeri kullanılır.

Örnek montaj noktaları:
- `/` (kök dizin)
- `/home` (kullanıcı ev dizinleri)
- `/mnt/data` (harici veri depolama alanı)
- `/media/usb` (taşınabilir medya için)

### 3. Dosya Sistemi Türü (`<tür>`)

Bölümün veya aygıtın dosya sistemi türünü tanımlar.

### 4. Montaj Seçenekleri (`<seçenekler>`)

Dosya sisteminin nasıl monte edileceğini belirleyen seçenekler. Virgülle ayrılmış bir liste olarak belirtilir.

### 5. Dump Değeri (`<dump>`)

`dump` yedekleme aracının bu dosya sistemini yedekleyip yedeklemeyeceğini belirler:
- `0`: Yedekleme yapılmaz (en yaygın değer)
- `1`: Yedekleme yapılır (genellikle kök dizin için)

### 6. Fsck Sırası (`<pass>`)

`fsck` aracının sistem başlangıcında dosya sistemlerini kontrol etme sırasını belirler:
- `0`: Kontrol yapılmaz
- `1`: İlk kontrol edilecek dosya sistemi (genellikle kök dosya sistemi için)
- `2`: Diğer kontrol edilecek dosya sistemleri

## Dosya Sistemlerini Tanımlama Yöntemleri

fstab dosyasında dosya sistemlerini tanımlamak için üç farklı yöntem kullanılabilir. Her yöntemin kendine özgü avantajları ve dezavantajları vardır.

### 1. Kernel İsimlendirmesi

En temel yöntem, aygıtları `/dev/` dizini altındaki adlarıyla tanımlamaktır:

```
/dev/sda1    /    ext4    defaults    1    1
```

Kernel isimlendirmelerini listelemek için:

```bash
sudo fdisk -l
```

**Avantajları**: Kolay anlaşılır, doğrudan aygıt yollarını kullanır.

**Dezavantajları**: Disk sıralaması değiştiğinde (donanım değişikliği, BIOS ayarları vb.) montaj işlemleri başarısız olabilir.

### 2. UUID ile Tanımlama

UUID'ler, her dosya sistemi için benzersiz tanımlayıcılardır ve disk sıralamasından bağımsızdır:

```
UUID=6a60524d-061d-454a-bfd1-38989910eccd    /    ext4    defaults    1    1
```

UUID değerlerini görmek için:

```bash
sudo blkid
```

**Avantajları**: Disk sıralamasından bağımsızdır, her dosya sistemi için benzersizdir.

**Dezavantajları**: Okunması ve yazılması daha zordur, yazım hataları yapılabilir.

### 3. Etiketler ile Tanımlama

Etiketler, kullanıcı dostu ve anlaşılır tanımlayıcılardır:

```
LABEL=Debian    /    ext4    defaults    1    1
```

Bir ext2/3/4 bölümüne etiket atamak için:

```bash
sudo e2label /dev/sda1 Debian
```

**Avantajları**: İnsan tarafından okunabilir, anlamlı isimler kullanılabilir.

**Dezavantajları**: Aynı etiketin birden fazla dosya sistemine atanması soruna neden olabilir.

## Sık Kullanılan Dosya Sistemi Türleri

| Tür | Açıklama |
|-----|----------|
| `ext4` | Linux için standart ve yaygın dosya sistemi |
| `ext3` | Eski bir Linux dosya sistemi, journaling desteği ile |
| `ext2` | Çok temel bir Linux dosya sistemi, journaling olmadan |
| `btrfs` | Gelişmiş özelliklere sahip modern Linux dosya sistemi |
| `xfs` | Yüksek performanslı ve ölçeklenebilir dosya sistemi |
| `ntfs` | Windows işletim sistemlerinin dosya sistemi |
| `vfat` | Windows ve Linux uyumlu (FAT32) dosya sistemi |
| `exfat` | Genişletilmiş FAT dosya sistemi, büyük dosyalar için |
| `swap` | Takas alanı için özel dosya sistemi |
| `tmpfs` | RAM üzerinde geçici dosya sistemi |
| `nfs` | Ağ Dosya Sistemi, uzak sunucu erişimi için |
| `cifs` | Windows ağ paylaşımları için protokol |
| `auto` | Otomatik algılama, genellikle çıkarılabilir medya için |

## Montaj Seçenekleri

Montaj seçenekleri, dosya sistemlerinin nasıl monte edileceğini ve davranacağını belirler. Bu seçenekler virgülle ayrılmış bir liste olarak belirtilir.

### Temel Seçenekler

| Seçenek | Açıklama |
|---------|----------|
| `defaults` | Varsayılan seçenekleri kullanır: rw,suid,dev,exec,auto,nouser,async |
| `auto` | Başlangıçta veya `mount -a` komutu ile otomatik monte edilir |
| `noauto` | Yalnızca açık bir şekilde istediğinizde monte edilir |
| `user` | Normal kullanıcıların monte etmesine izin verir (noexec,nosuid,nodev içerir) |
| `nouser` | Sadece root kullanıcısının monte etmesine izin verir (varsayılan) |
| `ro` | Salt okunur olarak monte et |
| `rw` | Okunur-yazılır olarak monte et (varsayılan) |

### Güvenlik Seçenekleri

| Seçenek | Açıklama |
|---------|----------|
| `exec` | Dosya sistemindeki çalıştırılabilir dosyaların çalıştırılmasına izin verir (varsayılan) |
| `noexec` | Dosya sistemindeki çalıştırılabilir dosyaların çalıştırılmasını engeller |
| `suid` | SUID ve SGID bitlerinin çalışmasına izin verir (varsayılan) |
| `nosuid` | SUID ve SGID bitlerinin çalışmasını engeller |
| `dev` | Aygıt dosyalarının yorumlanmasına izin verir (varsayılan) |
| `nodev` | Aygıt dosyalarının yorumlanmasını engeller |

### Performans Seçenekleri

| Seçenek | Açıklama |
|---------|----------|
| `sync` | G/Ç işlemlerinin senkron yapılmasını sağlar |
| `async` | G/Ç işlemlerinin asenkron yapılmasını sağlar (varsayılan) |
| `noatime` | Dosyalara erişim zamanlarını güncelleme (performans artışı sağlar) |
| `nodiratime` | Dizinlere erişim zamanlarını güncelleme (performans artışı sağlar) |
| `relatime` | Erişim zamanını, yalnızca değişiklik veya oluşturma zamanından daha eskiyse günceller |
| `data=ordered/journal/writeback` | Ext4 dosya sistemlerinde journaling modları |
| `barrier=0/1` | Veri bütünlüğü için yazma bariyerlerini devre dışı/etkin bırakır |

### Ağ Dosya Sistemleri için Seçenekler

| Seçenek | Açıklama |
|---------|----------|
| `_netdev` | Ağ bağlantısı kurulduktan sonra monte edilmesini sağlar |
| `retry=n` | Bağlantı hatalarında tekrar deneme sayısı |
| `credentials=dosya` | Kimlik bilgilerinin saklandığı dosya yolu |
| `uid=x` | Dosyaların sahibi olarak atanacak kullanıcı ID'si |
| `gid=y` | Dosyaların grubu olarak atanacak grup ID'si |
| `file_mode=0xxx` | Dosya izinleri (örn. 0644) |
| `dir_mode=0xxx` | Dizin izinleri (örn. 0755) |

## Örnek Senaryolar ve Yapılandırmalar

### Kök Dosya Sistemi

```
UUID=6a60524d-...    /    ext4    defaults    1    1
```

### Kullanıcı Ev Dizini

```
UUID=8e4b6d38-...    /home    ext4    defaults,noatime    0    2
```

### Takas Alanı (Swap)

```
UUID=7e4a6c27-...    none    swap    sw    0    0
```

### Geçici Dosya Sistemi (RAM Disk)

```
tmpfs    /tmp    tmpfs    size=2G,mode=1777    0    0
```

### Harici USB Disk (Otomatik Montaj)

```
UUID=xxx    /media/external    ext4    defaults,nofail    0    2
```

`nofail` seçeneği, aygıt bağlı değilse başlatma sırasında hata vermesini önler.

### Windows NTFS Bölümü

```
UUID=xxx    /mnt/windows    ntfs    defaults,uid=1000,gid=1000,umask=022    0    0
```

### Windows Ağ Paylaşımı (SMB/CIFS)

```
//server/share    /mnt/win_share    cifs    credentials=/etc/samba/credentials,uid=1000,gid=1000    0    0
```

Credentials dosyası (`/etc/samba/credentials`):
```
username=kullanıcı
password=parola
domain=alan
```

### NFS Paylaşımı

```
server:/export    /mnt/nfs_share    nfs    defaults,_netdev    0    0
```

### CD/DVD Sürücüsü

```
/dev/sr0    /media/cdrom    iso9660    ro,user,noauto    0    0
```

### Güvenli Geçici Dizin

```
tmpfs    /tmp    tmpfs    defaults,noexec,nosuid,nodev,size=2G    0    0
```

## Sorun Giderme

### Yaygın Sorunlar ve Çözümleri

1. **Sistem Başlangıcında Montaj Hatası**

   *Sorun*: Bir dosya sistemi monte edilemiyor ve sistem acil durum kabuğu başlatıyor.
   
   *Çözüm*:
   ```bash
   # Acil durum kabuğunda kök dizini yazılabilir olarak yeniden monte et
   mount -o remount,rw /
   
   # fstab dosyasını düzenle
   nano /etc/fstab
   
   # Sorunlu satırı devre dışı bırak veya düzelt
   # Sonra yeniden başlat
   reboot
   ```

2. **Geçersiz UUID veya Etiket**

   *Sorun*: UUID veya etiket değişti veya yanlış yazıldı.
   
   *Çözüm*:
   ```bash
   # Doğru UUID'yi kontrol et
   sudo blkid
   
   # fstab dosyasını düzenle
   sudo nano /etc/fstab
   ```

3. **Montaj Noktası Bulunamadı**

   *Sorun*: Belirtilen montaj noktası mevcut değil.
   
   *Çözüm*:
   ```bash
   # Montaj noktasını oluştur
   sudo mkdir -p /mnt/noktası
   
   # Tekrar dene
   sudo mount -a
   ```

4. **Dosya Sistemi Türü Hatası**

   *Sorun*: Belirtilen dosya sistemi türü yanlış veya eksik modül.
   
   *Çözüm*:
   ```bash
   # Doğru dosya sistemi türünü kontrol et
   sudo blkid /dev/sdXY
   
   # Gerekli modülü yükle (örn. NTFS için)
   sudo apt-get install ntfs-3g
   ```

5. **Ağ Dosya Sistemi Hatası**

   *Sorun*: Ağ erişilebilir olmadan önce monte etmeye çalışılıyor.
   
   *Çözüm*:
   ```bash
   # _netdev seçeneğini ekle
   //server/share  /mnt/share  cifs  credentials=/etc/cifs,_netdev  0  0
   ```

### Tanılama Komutları

```bash
# fstab dosyasını kontrol et
sudo findmnt --verify

# Montaj hatalarını göster
sudo mount -a -v

# Anlık montaj durumunu göster
mount | column -t

# Dosya sistemi kullanımını göster
df -h
```

## Yararlı Komutlar

```bash
# Disk ve bölümleri listele
sudo fdisk -l

# UUID'leri görüntüle
sudo blkid

# Bağlı dosya sistemlerini listele
mount | column -t

# Tüm bölümleri monte et
sudo mount -a

# Etiket ata (ext partisyonlar için)
sudo e2label /dev/sda1 Etiket

# fstab yedeği al
sudo cp /etc/fstab /etc/fstab.backup

# Dosya sistemi tipi kontrol et
lsblk -f

# Montaj noktası bilgilerini göster
findmnt

# Belirli bir dosya sistemini test et
sudo mount -o remount /mnt/test
```

## En İyi Uygulamalar

1. **UUID Kullanımı**
   - Disk sıralaması değişikliklerinden etkilenmeyi önlemek için UUID kullanın
   - LVM bölümleri için mantıksal birim yollarını kullanın (`/dev/mapper/vg-lv`)

2. **Güvenlik Önlemleri**
   - Kullanıcıların monte etmesine izin verilen dosya sistemleri için `noexec`, `nosuid` ve `nodev` seçeneklerini kullanın
   - Kritik olmayan yollar için `noexec` seçeneğini kullanarak güvenliği artırın

3. **Performans İyileştirmeleri**
   - SSD'ler için `noatime` veya `relatime` seçeneklerini kullanın
   - Yüksek G/Ç yükü olan sistemlerde `commit=30` gibi seçeneklerle senkronizasyon sıklığını ayarlayın

4. **Dosya Sistemi Bakımı**
   - Kök dizin için `pass` değerini 1, diğer sistemler için 2 olarak ayarlayın
   - Kritik olmayan dosya sistemleri için `nofail` seçeneğini kullanarak sistem başlangıcının hatasız olmasını sağlayın

5. **Değişiklik Yönetimi**
   - fstab değişikliklerinden önce daima yedek alın
   - Değişikliklerden sonra `mount -a` komutu ile test edin
   - Karmaşık yapılandırmalar için yorum satırları ekleyin

## fstab Cheatsheet

### Hızlı Referans

```
# Temel Sözdizimi
<dosya sistemi>   <montaj noktası>   <tür>   <seçenekler>   <dump>   <pass>

# Kök Dizin
UUID=xxx    /    ext4    defaults    1    1

# Ev Dizini
UUID=xxx    /home    ext4    defaults,noatime    0    2

# Takas Alanı
UUID=xxx    none    swap    sw    0    0

# Geçici Dosya Sistemi
tmpfs    /tmp    tmpfs    size=2G,mode=1777    0    0

# Windows Paylaşımı
//server/pay    /mnt/win    cifs    credentials=/etc/cifs,uid=1000    0    0

# NFS Paylaşımı
server:/veri    /mnt/nfs    nfs    defaults,_netdev    0    0

# CD/DVD
/dev/sr0    /media/cdrom    iso9660    ro,user,noauto    0    0

# Harici Disk
UUID=xxx    /media/external    ext4    defaults,nofail    0    2
```

### Tanılama Komutları Cheatsheet

```bash
# UUID listele
sudo blkid

# fstab test et
sudo mount -a

# Anlık montaj durumu
mount | column -t

# Dosya sistemi kullanımı
df -h

# Dosya sistemi tipleri
lsblk -f

# Montaj noktaları
findmnt

# fstab doğrulama
sudo findmnt --verify
```

---

Bu kapsamlı rehber, Debian sistemlerinde fstab dosyasını etkili bir şekilde yapılandırmanız ve yönetmeniz için gerekli tüm bilgileri içermektedir. Farklı senaryolar için örnekler ve en iyi uygulamalar, sistem yöneticileri ve Linux kullanıcıları için değerli bir referans kaynak oluşturmaktadır.

**Not**: Dosya sistemi yapılandırmasında değişiklik yapmadan önce her zaman mevcut fstab dosyanızı yedekleyin ve dikkatli olun. Yanlış yapılandırmalar, sisteminizin düzgün bir şekilde önyükleme yapmasını engelleyebilir.
