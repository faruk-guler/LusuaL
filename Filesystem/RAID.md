# RAID (Redundant Array of Independent Disks)
Birden fazla sabit diski bir araya getirerek veri depolama performansını ve/veya güvenilirliğini artırmak için kullanılan bir teknolojidir.
RAID, verileri farklı diskler arasında bölerek veya kopyalayarak çalışır ve farklı RAID seviyeleri vardır. (önemli seviyeler: RAID 0, RAID 1, RAID 5, RAID 10)

RAID 0 (Striping): En az 2 disk kullanarak sunucu performansını artıran bir sistemdir. 
Verileri bu diskler arasında bölerek eş zamanlı yazmaya olanak tanır, ancak hata toleransı yoktur. Bir disk arızalanırsa tüm veriler kaybolur.

RAID 1 (Mirroring): En az 2  disk gerektirir. Disk yansıtma olarak da bilinir. Veriler, sürekli olarak bir diskten diğerine birebir kopyalanır.
2 adet 2 TB disk kullanıldığında toplam (ham kapasite) 4 TB olsa da, kullanılabilir depolama alanı yalnızca 2 TB olur.

RAID 5: En az 3 disk gerektiren yaygın olarak kullanılan bir sistemdir. Depolama kapasitesini üçte bir oranında azaltırken daha iyi yazma performansı sunar. 
Bir disk arızalanırsa, veriler bir eşlik bloğu kullanılarak otomatik olarak kurtarılabilir.
Bu da sistemin hasarlı disk değiştirilene kadar düşük kapasiteyle çalışmasını sağlar.

RAID 10 (1+0): En az 4 disk gerektirir ve RAID 0 ve RAID 1'in özelliklerini birleştirir.
Tek bir diske kıyasla dört kat daha fazla okuma ve iki kat daha fazla yazma hızı sunar. Sadece çift sayıda diskler ile çalışır.
Yüksek performans ihtiyaçları için faydalıdır.

-
-
-