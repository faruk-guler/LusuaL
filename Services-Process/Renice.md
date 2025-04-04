# Linux Süreç Öncelik Yönetimi: `renice` Komple Kılavuzu

## Komut Tanımı ve Önem

`renice`, Linux sistemlerinde çalışan süreçlerin CPU öncelik değerlerini ("nice" değeri) dinamik olarak değiştiren bir komuttur. Bu komut, kaynak dağılımını optimize etmek ve süreçlerin önceliğini yönetmek için kullanılır. 

### Temel Özellikler:
- **Öncelik Aralığı**: -20 (en yüksek öncelik) ile 19 (en düşük öncelik)
- **Varsayılan Değer**: 0
- **Yetki Sistemi**:
  - Normal kullanıcılar: 0→19 (sadece öncelik düşürme)
  - Root (Yönetici): -20→19 (tam erişim)

## Temel Kullanım

`renice` komutu ile bir sürecin önceliği değiştirilir. Bu işlem için genellikle PID (process ID) veya kullanıcı/grup adı kullanılır.

### Öncelik Değiştirme (PID ile)
```bash
renice -n 10 -p 1234  # PID 1234'ün nice değerini 10 yap
