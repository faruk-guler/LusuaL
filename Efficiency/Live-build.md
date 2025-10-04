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
```

## Config:
```bash
sudo lb config noauto \
  --distribution stable \
  --architectures amd64 \
  --debian-installer live \
  --debian-installer-gui false
  --archive-areas "main" \
  --debootstrap-options "--variant=minbase"
  --bootstrap-flavour minimal
  --binary-images iso-hybrid
  --apt-indices false
  --iso-application "My-Guler-IMAGE"
```

## Package List:
```bash
echo "nano openssh-server" > config/package-lists/package.list.chroot
echo "grub-pc grub-efi-amd64-bin grub-efi-amd64-signed shim-signed" > config/package-lists/bootloader.chroot
echo "live-boot live-config live-config-systemd systemd-sysv" > config/package-lists/live.list.chroot
```

## Customize the Installer content: [image and text]
```bash
mkdir -p config/includes.binary/boot/grub
mkdir -p config/includes.binary/isolinux
cat > config/includes.binary/isolinux/stdmenu.cfg <<'EOF'
MENU TITLE Minimal Debian Installer -farukguler.com
TIMEOUT 50
EOF
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
