######################
#parted:             #
######################

sudo apt install parted      # Debian/Ubuntu
sudo dnf install parted      # Fedora
sudo pacman -S parted        # Arch/Manjaro


sudo parted /dev/sdd
print
quit

#Disk Yedekleme - Taşıma:
sudo dd if=/dev/sda of=/path/to/backup.img bs=4M

#xxx
mklabel gpt        # GPT bölümleme tablosu oluştur > 2 TB'a kadar olan diskler için.
mklabel msdos      # MBR (MSDOS) bölümleme tablosu oluştur > 9.4 zettabytes (ZB) kadar olan diskler için.
mkpart primary ext4 0% 50%      # İlk bölümü oluştur (0% - 50%)
mkpart logical ext4 50% 100%    # İkinci bölümü oluştur (50% - 100%)

```sh
Bölüm Silme ve Yeniden Boyutlandırma:
sudo parted /dev/sda
(parted) print                  # Bölüm yapısını kontrol et
(parted) rm 2                    # 2 numaralı bölümü sil
(parted) resizepart 1 120GB      # 1 numaralı bölümü 120GB'a çıkar
(parted) quit

#GPT Disk Bölümlendirme: (Daha yeni Sistemler İçin)
sudo parted /dev/sda
(parted) mklabel gpt           # Yeni GPT bölümlendirme tablosu oluştur
(parted) mkpart primary ext4 0% 50%    # İlk bölüm
(parted) mkpart primary ext4 50% 100%  # İkinci bölüm
(parted) print                  # Bölüm yapısını kontrol et
(parted) quit                   # çık

#MBR Bölümlendirme: (Eski Sistemler İçin)
sudo parted /dev/sdb
(parted) mklabel msdos          # MBR bölümleme tablosu oluştur
(parted) mkpart primary ext4 0% 25%    # İlk bölüm (0% - 25%)
(parted) mkpart primary ext4 25% 50%   # İkinci bölüm (25% - 50%)
(parted) print                  # Bölüm yapısını kontrol et
(parted) quit                   # çık
```

#Bölüm İşaretleme: (Flag)
(parted) set 1 boot on

#Hizalama: (Alignment)          #Bölümleri SSD veya modern disklerde performans için hizalamak önemlidir:
(parted) align-check optimal [PARTITION-NUMBER]

#Betikleme: (Scripting)        #Komutları doğrudan terminalden çalıştırma:
sudo parted /dev/sda --script 'mklabel gpt mkpart primary ext4 1MiB 5GiB print quit'

#Kayıp Bölüm Kurtarma:
(parted) rescue START END  # Belirtilen aralıkta kayıp bölüm arar.

