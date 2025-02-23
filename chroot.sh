##Chroot (Change Root)
Chrootbir sürecin ve alt süreçlerinin dosya sistemi kök dizinini değiştiren bir Unix/Linux sistem çağrısıdır.
Bir programı veya kullanıcıyı belirli bir dizin "izole edilmiş" bir ortamda çalıştırmanıza olanak tanır.
Bu izole ortam, genellikle chroot jail (chroot hapishanesi) olarak adlandırılır.

#Requirements
-LiveCD/USB and SystemRescueCD
-Shell
-Root

---------------------------
test@debian:~$  lsblk -p
sda      
├─sda1    (EFI Boot Partition)
├─sda2    (Linux root "/")
└─sda3    (Swap)
----------------------------

#Gerekli Bölümleri Mount Edin (Opsiyonel):
sudo mount /dev/sda2 /mnt          # kök dosya sisteminiz /dev/sda2 üzerindeyse
sudo mount /dev/sda1 /mnt/boot     # Ayrı bir /boot Bölümünüz Varsa
sudo mount /dev/sda1 /mnt/boot/efi # EFI sistem kullanıyorsanız
sudo mount /dev/sdXZ /mnt/boot     # /boot için
sudo mount /dev/sdXA /mnt/home     # /home için

#Sistem Dizinlerini Mount Edin (Bind Mounts):
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
sudo mount --bind /run /mnt/run  # Özellikle systemd kullanıyorsanız

# >>> Chroot Ortamına Geçin:
sudo chroot /mnt /bin/bash # bash ile
sudo chroot /mnt /bin/sh   # farklı bir shell ile
sudo chroot /mnt/sysimage  # farklı bir dizine geçin
exit

#-- /boot Dizini Onarma:
mkdir -p /boot      #Eğer /boot Dizini Silindiyse/Eksikse
mkdir -p /boot/efi  # EFI sistem kullanıyorsanız

#-- Bozuk Bootloader (GRUB) Onarma:
grub-install /dev/sda   # Örnek: grub-install /dev/sda
grub-install --recheck /dev/sda
update-grub             # GRUB yapılandırmasını güncelle

#-- Fstab Düzenleme:
nano /etc/fstab

#-- Paketleri Onarma:
apt update
apt install --reinstall paket-adı  # Bozuk bir paketi yeniden yükle
apt upgrade                        # Sistem güncellemesi

#-- Bozuk Paketleri Düzelt:
sudo dpkg --configure -a
sudo apt-get install -f

#-- Eksik Dosyaları Canlı Ortamdan Kopyalama:
sudo ldd /bin/bash         # Eksik  dosyaları espit et:
cp -L /bin/bash /mnt/bin/  # /bin/bash Silinmişse
cp -r /etc/apt /mnt/etc/   # apt dizini silinmişse

#-- Parola Sıfırlama:
passwd root
passwd faruk  # Root and other users

#-- Kernel Dosyalarını Güncelleyin veya Düzenleyin:
apt get-update
apt-get install --reinstall linux-image-$(uname -r)

#-- Sistemd Servislerini Onarma:
apt install --reinstall systemd   # Debian/Ubuntu
dnf reinstall systemd             # CentOS/RHEL
systemctl daemon-reexec           # Sistemd'yi yeniden başlatın:

#-- Saati senkronize edin:
hwclock --systohc

#-- Zaman dilimini ayarla:
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

#-- Ağ Bağlantısı yapma:
cp /etc/resolv.conf /mnt/etc/resolv.conf # Chroot içinde ağ gerekiyorsa


# >>> Chroottan Çıkış ve Unmount işlemi:
exit
sudo umount /mnt
sudo umount /mnt/dev
sudo umount /mnt/proc
sudo umount /mnt/sys
sudo umount /mnt/run     # Eğer bağladıysanız
reboot

#Extras:
https://dev.to/aciklab/linux-sistemlerde-chroot-kullanarak-imaj-dosyalarina-baglanma-2npc

------------------------------------------------------------------
# >>> Önemli Notlar:
-Chroot çıkmadan önce tüm bölümleri ayırdığınızdan emin olun:
- Alternatif Shell: Chroot'ta /bin/bash çalışmazsa /bin/sh veya /bin/dash kullanın.
-Disk Bölümünü Doğru Seçtiğinizden Emin Olun.
-Root (/) ve varsa ayrı /boot bölümlerini yanlış bağlamayın.
-İşlem öncesinde diskteki verilerin yedeğini alın.
-Sisteminizin UEFI mi yoksa BIOS mu kullandığını bilmeniz kritiktir.
-Sisteminize uygun kernel sürümünü yükleyin (örneğin, linux-image-5.15.0-76-generic).
-UEFI kullanıyorsanız ve GRUB menüsü görünmüyorsa, BIOS'ta "Secure Boot" ayarını kapatın.
-İşlem sonu Kernel’in mevcut olup olmadığını kontrol edin, yoksa yeniden yükleyin: [ls /boot/vmlinuz*]
-Alternatif Araçlar: systemd-nspawn, arch-chroot
