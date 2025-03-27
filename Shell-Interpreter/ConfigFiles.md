# Shell Yapılandırma Dosyaları

## Shell Yapılandırma Dosyaları

### 1.1 Bash (Bourne-Again Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.bashrc` | Interaktif oturum ayarları | Her terminal açılışında | ❌ |
| `~/.bash_profile` | Login shell ayarları | Kullanıcı girişinde | ❌ |
| `~/.bash_logout` | Çıkış komutları | Shell'den çıkışta | ❌ |
| `/etc/bash.bashrc` | Global bash ayarları | Tüm kullanıcılarda | ✔️ |

### 1.2 Zsh (Z Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.zshrc` | Interaktif oturum ayarları | Her terminal açılışında | ❌ |
| `~/.zprofile` | Login shell ayarları | Kullanıcı girişinde | ❌ |
| `/etc/zshrc` | Global zsh ayarları | Tüm kullanıcılarda | ✔️ |

### 1.3 Fish (Friendly Interactive Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.config/fish/config.fish` | Tüm yapılandırma | Her shell başlangıcında | ❌ |
| `/etc/fish/config.fish` | Global ayarlar | Tüm kullanıcılarda | ✔️ |

### 1.4 **Diğer Shell'ler**
- **sh (Bourne Shell)**: Temel kabuk, betikler için ideal.
- **ksh (Korn Shell)**: Yüksek performanslı betikleme.
- **dash**: Hafif versiyon (`/bin/sh` genellikle dash'e bağlı).
