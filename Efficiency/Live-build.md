What is Debian Live-Build?

live-build is a set of scripts used to create Debian-based live system images (ISO, USB, netboot, etc.) and is one of the core tools of the Debian Live Project.

## Install:
```bash
apt update
apt upgrade
apt install live-build
```

## Create work directory:
```bash
mkdir debian-minimal-iso
cd debian-minimal-iso
git clone git://git.debian.org/git/debian-live/live-build.git
```

## Config:
```bash
sudo lb config noauto \
  --distribution stable \
  --architectures amd64 \
  --debian-installer live \
  --bootloader syslinux \
  --apt-indices false \
  --apt-recommends false \
  --debian-installer-gui false \
  --debian-installer true \
  --archive-areas "main" \
  --bootappend-live "boot=live components quiet splash" \
  --bootloader grub-efi \
  --checksums sha256 \
  --compression gzip \
  --memtest none \
  --debian-installer-distribution trixie \
  --firmware-chroot false \
  --firmware-binary false \
  --debootstrap-options "--variant=minbase" \
  --bootstrap-flavour minimal \
  --bootappend-live "boot=live quiet splash" \
  --binary-images iso-hybrid \
  --apt-indices false \
  --iso-application "My-Guler-IMAGE"
```

## Package List:
```bash
echo "nano openssh-server" > config/package-lists/package.list.chroot
echo "grub-pc grub-efi-amd64-bin grub-efi-amd64-signed shim-signed" > config/package-lists/bootloader.chroot
echo "live-boot live-config live-config-systemd systemd-sysv busybox syslinux grub-pc-bin grub-common" > config/package-lists/live.list.chroot
```

# SSH Configuration:
```bash
mkdir -p config/hooks/live
cat > config/hooks/live/02-configure-ssh.hook.chroot << 'EOF'
#!/bin/sh
# SSH servisini etkinleştir
systemctl enable ssh

# SSH yapılandırması
cat >> /etc/ssh/sshd_config << 'SSHEOF'

# Özel ayarlar
PermitRootLogin yes
PasswordAuthentication yes
SSHEOF
EOF
```

## Customize the Installer content: [image and text]
```bash
logo: cp splash.png config/bootloaders/isolinux/splash.png (640x480 PNG)
mkdir -p config/includes.binary/boot/grub
mkdir -p config/includes.binary/isolinux
cat > config/includes.binary/isolinux/stdmenu.cfg <<'EOF'
MENU TITLE Minimal Debian Installer -farukguler.com
TIMEOUT 50
EOF
```

## Customize the Installer content: [/etc/issue and /etc/motd]
```bash
mkdir -p config/includes.chroot/etc
echo "Welcome to My Secure Server Live Environment" > config/includes.chroot/etc/issue
echo "Unauthorized access prohibited." > config/includes.chroot/etc/motd
```

## Builder:
```bash
lb build
lb build 2>&1 | tee build-log.txt
```

## Reconfigure:
```bash
lb clean
# lb clean --purge [clear config dir.]
```

## Verify:
```bash
mv live-image-amd64.hybrid.iso mybuild.iso
md5sum mybuild.iso > mybuild.md5
md5sum -c mybuild.md5
```

## links:
https://manpages.debian.org/unstable/live-build/lb_config.1.en.html
