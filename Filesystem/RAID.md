# RAID (Redundant Array of Independent Disks)
Birden fazla sabit diski bir araya getirerek veri depolama performansını ve/veya güvenilirliğini artırmak için kullanılan bir teknolojidir.
RAID, verileri farklı diskler arasında bölerek veya kopyalayarak çalışır ve farklı RAID seviyeleri vardır. (önemli seviyeler: RAID 0, RAID 1, RAID 5, RAID 10)

RAID 0 (Striping-Şeritleme): En az 2 disk kullanarak sunucu performansını artıran bir sistemdir. 
Verileri bu diskler arasında bölerek eş zamanlı yazmaya olanak tanır, ancak hata toleransı yoktur. Bir disk arızalanırsa tüm veriler kaybolur.

RAID 1 (Mirroring-Aynalama): En az 2  disk gerektirir. Disk yansıtma olarak da bilinir. Veriler, sürekli olarak bir diskten diğerine birebir kopyalanır.
2 adet 2 TB disk kullanıldığında toplam (ham kapasite) 4 TB olsa da, kullanılabilir depolama alanı yalnızca 2 TB olur.

RAID 5: En az 3 disk gerektiren yaygın olarak kullanılan bir sistemdir. Depolama kapasitesini üçte bir oranında azaltırken daha iyi yazma performansı sunar. 
Bir disk arızalanırsa, veriler bir eşlik bloğu kullanılarak otomatik olarak kurtarılabilir.
Bu da sistemin hasarlı disk değiştirilene kadar düşük kapasiteyle çalışmasını sağlar.

RAID 10 (1+0): En az 4 disk gerektirir ve RAID 0 ve RAID 1'in özelliklerini birleştirir. Sadece çift sayıda diskler ile çalışır.
Veriler diskler arasında eşit olarak şeritlenir ve bunlar da yansıtılır. Yüksek performans ihtiyaçları için faydalıdır. Kullanılabilir kapasite toplam disk kapasitesinin yarısıdır. (örneğin, 4x2TB = 4TB kullanılabilir)

-
-

## **RAID Levels**  

Different RAID configurations, known as **RAID levels**, provide varying degrees of **redundancy, speed, and storage efficiency**.  

| **RAID Level** | **Description** | **Pros** | **Cons** |
|--------------|-----------------|-----------|----------|
| **RAID 0 (Striping)** | Data is split across multiple disks for speed. **No redundancy.** | High performance | No fault tolerance |
| **RAID 1 (Mirroring)** | Data is duplicated on two disks. If one fails, the other takes over. | High redundancy | Uses double the storage |
| **RAID 5 (Striping with Parity)** | Data is spread across disks with **parity for recovery**. Requires **3+ disks**. | Balanced speed, storage, and redundancy | Slower writes due to parity calculation |
| **RAID 6 (Striping with Double Parity)** | Similar to RAID 5 but with **extra parity** for higher fault tolerance. Needs **4+ disks**. | Can survive **2 disk failures** | Slower than RAID 5 |
| **RAID 10 (RAID 1+0)** | Combines RAID 1 & RAID 0: **Mirroring + Striping**. Needs **minimum 4 disks**. | High performance & fault tolerance | Expensive (uses 50% of total storage) |



### **RAID Selection Guide**
- **Need high performance?** → **RAID 0** (if redundancy isn't important)  
- **Want redundancy and simple recovery?** → **RAID 1**  
- **Balanced performance & fault tolerance?** → **RAID 5**  
- **Extra protection against disk failures?** → **RAID 6**  
- **Best of speed and redundancy?** → **RAID 10**  
