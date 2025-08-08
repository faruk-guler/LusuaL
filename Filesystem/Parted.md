## Parted: 👹
Linux’ta parted aracı, disk bölümlerini (partition) yönetmek için kullanılan güçlü bir komut satırı aracıdır.
Hem MBR hem GPT disk yapısını destekler ve modern disk boyutlarıyla (2 TB üzeri) sorunsuz çalışır. 1999 yılından beri geliştirilmektedir.

- Disk Boyutu Desteği	GPT (>2TB <8ZB'ye kadar) ve MBR
- Dosya Sistemi Desteği	ext2/3/4, xfs, btrfs, fat, ntfs
- Yeniden Boyutlandırma	Dinamik (bazı FS'lerde)
- Kullanım	Etkileşimli ve komut satırı
- Gerçek Zamanlı Değişiklik	Bazı işlemler anında uygulanır

-----
```sh
root@debian:~# parted
GNU Parted 3.5
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted)
-------
```
-----


```sh
# Install:
sudo apt install parted        # Debian/Ubuntu
sudo dnf install parted        # Fedora/centos
sudo pacman -S parted          # Arch/Manjaro
sudo apk add parted            # Alpine Linux
sudo emerge -a sys-apps/parted # Gentoo Linux
sudo zypper install parted     # OpenSUSE

```

```sh
sudo parted /dev/sdd
print
quit
```

```sh
# Disk Tablosu Oluşturma [MBR/GPT]
(parted) mklabel gpt    # GPT için > 2 TB GPT
(parted) mklabel msdos  # MBR için < 2TB MBR
```
```sh
# Dosya Sistemi Oluşturma: [ex4/fat32...]
sudo mkfs.ext4 /dev/sda3
```

```sh
# Disk Yedekleme - Taşıma:
sudo dd if=/dev/sda of=/path/to/backup.img bs=4M
```

```sh
# Bölüm Silme ve Yeniden Boyutlandırma:
sudo parted /dev/sda
(parted) print                   # Bölüm yapısını kontrol et
(parted) rm 2                    # 2 numaralı bölümü sil
(parted) resizepart 1 120GB      # 1 numaralı bölümü 120GB'a çıkar
(parted) quit
```

```sh
# GPT Disk Bölümlendirme: (Daha yeni Sistemler İçin) [ex4/fat32...]
sudo parted /dev/sda
(parted) mklabel gpt            # Yeni GPT bölümlendirme tablosu oluştur
(parted) mkpart primary ext4 0% 50%    # İlk bölüm
(parted) mkpart primary ext4 50% 100%  # İkinci bölüm
(parted) print                  # Bölüm yapısını kontrol et
(parted) quit                   # çık

# MBR Bölümlendirme: (Eski Sistemler İçin) [ex4/fat32...]
sudo parted /dev/sdb
(parted) mklabel msdos          # MBR bölümleme tablosu oluştur
(parted) mkpart primary ext4 0% 25%    # İlk bölüm (0% - 25%)
(parted) mkpart primary ext4 25% 50%   # İkinci bölüm (25% - 50%)
(parted) print                  # Bölüm yapısını kontrol et
(parted) quit                   # çık
```

```sh
# Bölüm İşaretleme: (Flag)
(parted) set 1 boot on  # 1 numaralı bölümü önyükleme bölümü olarak işaretler.
(parted) set 1 esp on   # 1 numaralı bölümü EFI sistem bölümü (ESP) olarak işaretler
```

```sh
# Bölüm Boyutunu Değiştirme:
(parted) resizepart 1 2000MiB  # 1. bölümün bitişini 2000MB yapar.
```

```sh
# Hizalama: (Alignment)          #Bölümleri SSD veya modern disklerde performans için hizalamak önemlidir:
(parted) align-check optimal 1
```

```sh
# Betikleme: (Scripting)        #Komutları doğrudan terminalden çalıştırma:
sudo parted /dev/sda --script 'mklabel gpt mkpart primary ext4 1MiB 5GiB print quit'
```

```sh
# Kayıp Bölüm Kurtarma:
(parted) rescue 0% 100%  # Tüm diskte tarama yapar.
```

```sh
## Yeni Bir Disk Bölümleme:

>> Diski GPT olarak formatla:
sudo parted /dev/sdb --script 'mklabel gpt'

>> 500MB'lık EFI bölümü oluştur:
sudo parted /dev/sdb --script 'mkpart primary fat32 1MiB 500MiB set 1 esp on'

>> Kalan alana ext4 bölümü oluştur:
sudo parted /dev/sdb --script 'mkpart primary ext4 500MiB 100%'
```

```sh
# Varolan Bölümü Genişletme:

>> Bölümü bağlıysa kaldır:
sudo umount /dev/sda2

>> Bölüm boyutunu 20GB yap:
sudo parted /dev/sda resizepart 2 20GiB

>> Dosya sistemini genişlet:
sudo resize2fs /dev/sda2  # ext4 için
```

```sh
## Boot Edilebilir USB Oluşturmak:

1- USB sürücünüzü MBR formatında bölümleyin.
2- FAT32 dosya sistemi ile boot edilebilir bir bölüm oluşturun.
3- ISO dosyasını, dd komutuyla USB sürücüsüne yazın.

>> USB Diski MBR yap:
sudo parted /dev/sdc --script 'mklabel msdos'

>> Bootable FAT32 bölüm oluştur:
sudo parted /dev/sdc --script 'mkpart primary fat32 1MiB 4GiB set 1 boot on'

>> ISO'yu yaz:
sudo dd if=ubuntu.iso of=/dev/sdc1 bs=4M status=progress
```
```sh
Desteklenen bayraklar:
1 boot
2 root
3 swap
4 hidden
5 raid
6 lvm
7 lba
8 legacy_boot
9 irst
10 esp
11 palo
```
