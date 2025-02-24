##Systemd:
Modern Linux sistemlerinde servis yönetimi, önyükleme süreci ve sistem kaynaklarının izlenmesi için kullanılan bir init sistemidir.
SysV init'in yerini alarak daha hızlı başlangıç süreleri, paralel servis başlatma ve gelişmiş bağımlılık yönetimi sunar.
Ayrıca log yönetimi (journald), zamanlanmış görevler (timer birimleri) ve kullanıcı oturum yönetimi gibi ek özelliklerle genişletilmiş bir araç setidir.

--------------------------------------
|Unit Türü	| Uzantı  | Açıklama |
Service	  .service	Servisleri yönetir (ör: NGINX, MySQL).
Socket	  .socket	Ağ veya IPC soketlerini tanımlar. Bağlantı geldiğinde ilgili servisi başlatır.
Target	  .target	Hedef grupları (run level benzeri). Örn: multi-user.target.
Device	  .device	Donanım cihazlarını (USB, disk) sisteme tanıtır.
Mount	    .mount	Dosya sistemi mount işlemlerini yönetir (ör: /home bağlama).
Automount	.automount Otomatik mount işlemleri için (bağlantı noktasına erişimde tetiklenir).
Swap	    .swap	Swap alanını yönetir (takas dosyası/partition).
Timer	    .timer	Zamanlanmış görevler (cron benzeri).
Path	    .path	Dosya/dizin değişikliklerini izler ve bir servisi tetikler.
Slice	    .slice	Kaynak kısıtlaması için kayali "dilimler" (CPU, RAM kontrolü).
Scope	    .scope	Dış proses gruplarını izler (genellikle container'lar için).
Snapshot	.snapshot	Sistemin anlık durumunu kaydeder (geri yükleme için).
Link	    .link	Network interface'lerini yapılandırır (ör: MAC adresi atama).
Netdev	  .netdev	Sanal ağ cihazları oluşturur (ör: bridge, VLAN).
Network	  .network	Ağ yapılandırmasını tanımlar (IP, DNS, routing).
.............
