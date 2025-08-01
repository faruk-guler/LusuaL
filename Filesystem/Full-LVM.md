
# 🗃️🗃️🗃️ LVM (Logical Volume Management) -farukguler.com

Mantıksal Birim Yöneticisi (LVM), Linux sistemlerinde depolama yönetiminde esneklik sağlayan bir disk soyutlama katmanıdır. LVM, fiziksel diskleri soyutlayarak mantıksal bir depolama havuzu oluşturur ve bu havuzdan esnek mantıksal diskler (mantıksal birimler) tahsis etmenize olanak tanır. Bu, depolama alanınızı daha esnek bir şekilde yönetmenize, genişletmenize veya daraltmanıza imkan verir.

## LVM Mimarisi:
<p align="left">
  <img src="https://farukguler.com/assets/post_images/lvm-best.jpg" alt="LVM Logo" width="500"/>
</p>

```sh
# Name: İleriye dönük LVM optimize disk bölümleme planı
# Disk Space: 4TB
# ESP: UEFI sistem kullanılıyorsa EFI System Partition (ESP) alanı zorunludur.
# Yapı: /boot ve /boot/efi ayrı, veri alanları LVM içinde yönetilir.
# Swap: swap alanı gerekirse, /data altında "swapfile" oluşturulabilir.

  /dev/sda1     /dev/sda2          /dev/sda3 (PV)               <-------- PV_EXTEND -------->
-------------+-------------+----------------------------------+------------------------------+
/boot/efi    |  /boot      |  PV → VG: vg_data → LV: lv_*     |  (Genişletilebilir alan)     |
             |             |  lv_root, lv_data, lv_logs, ...  |                              |
             |             |  mount: /, /data, /home, /logs   |                              |
-------------+-------------+----------------------------------+------------------------------+              
  500MB–1GB      500MB               100–500GB                       ~2–3TB ort. boş alan
  FAT32           ext4                 LVM                                 -------
                                                                         ( VG içinde)
```

```sh
# Install LVM:
sudo apt install lvm2         # Debian/Ubuntu
sudo yum install lvm2         # RHEL/CentOS
sudo zypper install lvm2      # SUSE/openSUSE:
sudo lvm version

# LVM Configuration:
/etc/lvm/lvm.conf

## LV Yolları ve Alternatifler:
/dev/vg_name/lv_name           # Standart yol
/dev/mapper/vg_name-lv_name    # Device mapper yolu
/dev/dm-N                      # Düşük seviye device mapper aygıtı
```
```sh
## General view:
sudo pvscan    # Fiziksel Birimleri tara
sudo vgscan    # Birim Gruplarını tara
sudo lvscan    # Mantıksal Birimleri tara

## Fiziksel Disk Oluşturma (PV)
sudo pvcreate /dev/sdb            # Tek bir disk ekleme
sudo pvcreate /dev/sdb1           # Belirli bir bölümü ekleme
sudo pvcreate /dev/sdc /dev/sdd   # Birden fazla disk ekleme
sudo pvs                          # PV'leri listele
sudo pvdisplay                    # Detaylı bilgi göster

## Volume Group Oluşturma (VG)
sudo vgcreate vg_name /dev/sdb            # Tek bir PV ile VG oluşturma
sudo vgcreate vg_name /dev/sdb3           # Belirli bölümden VG oluşturma
sudo vgcreate vg_name /dev/sdb /dev/sdc   # Birden fazla PV ile VG oluşturma
sudo vgcreate --physicalextentsize 8G vg_name /dev/sdb # Özel PE boyutu ile VG oluşturma (örn. 8GB)
sudo vgcreate vg_veri /dev/sdb /dev/sdc   # "vg_veri" adında VG oluştur
sudo vgs                                  # VG'leri listele
sudo vgdisplay                            # Detaylı bilgi göster

## Logical Volume Oluşturma (LV)
sudo lvcreate -L 20G -n lv_home vg_veri         # 20GB'lık "lv_home" LV'si oluştur
sudo lvcreate -l 80%VG -n lv_name vg_name       # VG'nin yüzdesini kullanarak LV oluştur
sudo lvcreate -l 100%FREE -n lv_backup vg_veri  # Tüm boş alanı kullan
sudo lvs                                        # LV'leri listele
sudo lvdisplay                                  # Detaylı bilgi göster

## Dosya Sistemi Oluşturma ve Mount Etme
sudo mkfs.ext4 /dev/vg_veri/lv_home           # EXT4 dosya sistemi oluştur
sudo mkfs.xfs /dev/vg_name/lv_name            # XFS dosya sistemi oluştur
sudo mkdir /mnt/home                          # Mount dizini oluştur
sudo mount /dev/vg_veri/lv_home /mnt/home     # Mount et

## Kalıcı Mount /etc/fstab:
sudo cp /etc/fstab /etc/fstab.old
nano /etc/fstab
#/dev/vg_veri/lv_home /mnt/home ext4 defaults 0 0
#/dev/vg_veri/lv_home /mnt/home xfs defaults 0 0
#UUID=xxxx-xxxx /mnt/home ext4 defaults 0 0 (UUID ile güvenli önerilen)
sudo blkid | grep /dev/vg_veri/lv_home
sudo mount -av
sudo findmnt --verify

## LV Genişletme (Boyut Artırma )
################################
sudo lvextend -L +10G /dev/vg_veri/lv_home       # LV'ye belirli bir miktar alan ekleme (10GB)
sudo lvextend -l +100%FREE /dev/vg_name/lv_name  # LV VG'nin tüm boş alanını kullansın
sudo lvextend -l +80%FREE /dev/vg_name/lv_name   # LV VG'nin %80 alanını kullansın

## Dosya Sistemi Boyutlandırma (file system resizing extend/reduce)
#################################
sudo resize2fs /dev/vg_veri/lv_home        # EXT4 dosya sistemini boyutlandır
sudo xfs_growfs /mnt/home                  # XFS  dosya sistemini boyutlandır (daraltılamaz, sadece genişletilir.)

## LV Küçültme (Boyut Azaltma) ⚠️ Artırımın tersine işlem yapılır.
#################################
sudo umount /mnt/home                        # Önce unmount et
sudo e2fsck -f /dev/vg_name/lv_name          # Dosya sistemini kontrol et
sudo resize2fs /dev/vg_name/lv_name 15G      # Dosya sistemini küçült (15G)
sudo lvreduce -L 15G /dev/vg_name/lv_name    # LV boyutunu küçült (15GB)
sudo mount /dev/vg_name/lv_name /mnt/home    # Tekrar mount et
⚠️ Uyarı: LV küçültme işlemi veri kaybına yol açabilir. Verilerinizi yedekleyin!
```
```sh
## VG Genişletme (Yeni Disk Eklemek)
sudo pvcreate /dev/sdd                # Yeni disk ekle
sudo vgextend vg_veri /dev/sdd        # VG'ye ekle

## VG'den PV'yi Çıkarma/Küçültme (vgreduce)
sudo vgreduce vg_veri /dev/sdd

#LV Boyutlandırma: Extra Resize: (artırma veya azaltma yapar. ⚠️ Kontrolsüz kullanımda veri kaybı riski!)
lvresize -L -5G /dev/vg_name/lv_name
lvresize -L +5G /dev/vg_name/lv_name
```
```sh
## LVM Silme İşlemleri:
> LV Silme:
sudo umount /mnt/home
sudo lvremove /dev/vg_veri/lv_home

> VG Silme:
sudo vgremove vg_veri

> PV Silme:
sudo pvremove /dev/sdb

## LVM Metadata Yedekleme: (LVM config backup)
sudo vgcfgbackup -f /backup/vg_veri_backup vg_veri
sudo vgcfgrestore -f /backup/vg_veri_backup vg_veri
⚠️ Uyarı: Eski config mevcut volume group ayarlarını bozabilir, dikkatli olunmalıdır.
```
```sh
## Advanced LVM Management:
-LVM Snapshot
-lvrename, vgrename, pvrename
-lvconvert
-LVM thin provisioning
-LVM ile Şifreleme (LUKS)
-LVM archive ve LVM backup
-LVM Caching
-LVM ile RAID Entegrasyonu
-volume group migration
-pv migration
-BTRFS ve ZFS desteği
-
```
[LVM: Logical Volume Management - Install, Configure, Manage -farukguler.com](https://farukguler.com/posts/lvm-logical-volume-management-install-configure-manage/)