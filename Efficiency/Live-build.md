```bash
apt-get update
apt-get upgrade
apt-get install live-build
```

```bash
mkdir debian-minimal-iso
cd debian-minimal-iso
lb clean
lb clean --purge
```
```bash
mv live-image-amd64.hybrid.iso mybuild.iso
md5sum mybuild.iso > mybuild.md5
md5sum -c mybuild.md5
```

