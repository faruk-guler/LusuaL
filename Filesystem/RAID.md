# RAID (Redundant Array of Independent Disks)
Birden fazla sabit diski bir araya getirerek veri depolama performansını ve/veya güvenilirliğini artırmak için kullanılan bir teknolojidir.
RAID, verileri farklı diskler arasında bölerek veya kopyalayarak çalışır ve farklı RAID seviyeleri vardır. (önemli seviyeler: RAID 0, RAID 1, RAID 5, RAID 10)

RAID 0 (Striping): En az 2 disk kullanarak sunucu performansını artıran bir sistemdir. 
Verileri bu diskler arasında bölerek eş zamanlı yazmaya olanak tanır, ancak hata toleransı yoktur. Bir disk arızalanırsa tüm veriler kaybolur.

RAID 1 (Mirroring): Disk yansıtma olarak da bilinr. Verileri sürekli olarak bir diskten diğerine kopyalayarak, bir disk arızalansa bile verilerin kaybolmamasını sağlar. 
Ancak, Raid 0'a kıyasla daha düşük performansa sahiptir ve en az 2 disk gerektirir.
Raid 1 kurulumunda 2 TB'lık bir disk kullanıldığında, toplam depolama kapasitesi 2 TB değil, 2 TB olarak kalır.

Raid 5, En az 3 disk gerektiren yaygın olarak kullanılan bir sistemdir. Depolama kapasitesini üçte bir oranında azaltırken daha iyi yazma performansı sunar. 
Bir disk arızalanırsa, veriler bir eşlik bloğu kullanılarak otomatik olarak kurtarılabilir.
Bu da sistemin hasarlı disk değiştirilene kadar düşük kapasiteyle çalışmasını sağlar. 
Ancak, yoğun yazma işlemleri sırasında gecikmeler gösterebilir.

RAID 10 (1+0): En az 4 disk gerektirir ve Raid 0 ve Raid 1'in özelliklerini birleştirir.
Tek bir diske kıyasla dört kat daha fazla okuma ve iki kat daha fazla yazma hızı sunar. Sadece çift sayıda diskler ile çalışır.
Yüksek performans ihtiyaçları için faydalı olsa da, doğru şekilde uygulanmadığı takdirde avantajlarını kaybedebilir.

-
-