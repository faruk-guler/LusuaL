# Renice Komutu - Linux/Unix İşlem Önceliğini Değiştirme.

`renice`, Linux ve Unix tabanlı sistemlerde çalışan bir işlemin **nice değerini** değiştirerek işlem önceliğini ayarlamak için kullanılan bir komuttur. Bu, bir işlemin CPU zamanını ne kadar kullanacağını belirler.

## Nice Değeri Nedir?

Nice değeri, bir işlemin CPU'yu ne kadar öncelikli kullanacağına karar veren bir değerdir. Nice değeri -20 ile 19 arasında bir değer alabilir:

- **-20**: En yüksek öncelik (daha fazla CPU zamanı alır)
- **19**: En düşük öncelik (daha az CPU zamanı alır)
- **0**: Varsayılan değer (normal işlem önceliği)

## `renice` Komutunun Kullanımı

### 1. Bir İşlemin Önceliğini Değiştirme

```sh
renice -n [nice-değeri] -p [PID]
