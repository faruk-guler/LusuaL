#
/var/lib/apt/lists/: Depo meta verilerinin (paket bilgileri) saklandığı yer.
/var/cache/apt/archives/: İndirilen .deb paketlerinin önbelleği. (Temizlemek için: sudo apt clean)
/etc/apt/sources.list.d/: Ek yazılım kaynaklarının tanımlandığı dizin.
/etc/apt/sources.list: Ana yazılım kaynaklarının tanımlandığı dosya.
/etc/apt/apt.conf.d/: APT yapılandırma dosyalarını içeren dizin.
/etc/apt/preferences: Paketlerin sürüm ve öncelik ayarlarını belirleyen dosya.
/var/lib/apt/extended_states: Paketlerin manuel mi yoksa bağımlılık olarak mı yüklendiğini tutar.
/var/lib/dpkg/: Yüklü paketlerin veritabanı.
/var/lib/dpkg/status: Yüklü paketlerin durum bilgisini içerir.
/var/cache/apt/archives/partial/: Henüz tamamlanmamış paket indirme işlemleri burada saklanır.
/var/log/apt/: APT işlemleriyle ilgili log dosyalarını içerir (ör. history.log).
