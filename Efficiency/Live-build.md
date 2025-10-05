# What is Debian Live-Build?

live-build is a set of scripts used to create Debian-based live system images (ISO, USB, netboot, etc.) and is one of the core tools of the Debian Live Project.

## Install:
```bash
apt update
apt install live-build debootstrap xorriso squashfs-tools syslinux isolinux grub-pc-bin grub-efi-amd64-bin
apt install live-build debootstrap xorriso squashfs-tools grub-efi-amd64-bin

lb --version
```

## Create work directory:
```bash
mkdir debian-minimal-iso
cd debian-minimal-iso
```

## Config:
```bash
lb config noauto \
  --distribution stable \
  --architecture amd64 \
  --debian-installer live \
  --initramfs live-boot \
  --apt-indices false \
  --apt-recommends false \
  --linux-packages "linux-image" \
  --debian-installer-gui false \
  --archive-areas "main" \
  --mirror-bootstrap http://deb.debian.org/debian \
  --bootappend-live "boot=live components quiet splash" \
  --bootloaders "grub-efi-amd64"
  --uefi-secure-boot enable \
  --checksums sha256 \
  --compression gzip \
  --memtest none \
  --firmware-chroot false \
  --firmware-binary false \
  --debootstrap-options "--variant=minbase" \
  --binary-image iso-hybrid \
  --iso-application "My-Guler-IMAGE"
```

## Package List:
```bash
echo "nano openssh-server iproute2 net-tools ifupdown" > config/package-lists/package.list.chroot
echo "grub-efi-amd64-bin grub-efi-amd64-signed shim-signed" > config/package-lists/bootloader.chroot
echo "live-boot live-config live-config-systemd systemd-sysv grub-common" > config/package-lists/live.list.chroot
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
chmod +x config/hooks/live/02-configure-ssh.hook.chroot
```

## Customize the Installer content: [image and text]
```bash
mkdir -p config/includes.binary/boot/grub
cat > config/includes.binary/boot/grub/grub.cfg <<'EOF'
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
sudo lb build
sudo lb build 2>&1 | tee build-log.txt
```

## Reconfigure:
```bash
lb clean
# lb clean --purge [clear config dir.]
# rm -rf config/
```

## Verify:
```bash
mv live-image-amd64.hybrid.iso Debian-13-Trixie.iso
sha256sum Debian-13-Trixie.iso > mybuild.sha256
sha256sum -c mybuild.sha256
```

## links:
https://manpages.debian.org/unstable/live-build/lb_config.1.en.html
