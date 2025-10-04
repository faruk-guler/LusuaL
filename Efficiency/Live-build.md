## Install:
```bash
apt-get update
apt-get upgrade
apt-get install live-build
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
```
## Builder:
```bash
lb build
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





