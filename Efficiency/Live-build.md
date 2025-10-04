```bash
apt-get update
apt-get upgrade
apt-get install live-build
```

```bash
mkdir debian-minimal-iso
cd debian-minimal-iso
lb config
lb build
lb clean
lb clean --purge
```
```bash
mv live-image-amd64.hybrid.iso mybuild.iso
md5sum mybuild.iso > mybuild.md5
md5sum -c mybuild.md5
```

```bash
sudo lb config noauto \
  --distribution stable \
  --architectures amd64 \
  --debian-installer live \
  --debian-installer-gui false
  --archive-areas "main" \
  --debootstrap-options "--variant=minbase"
```





