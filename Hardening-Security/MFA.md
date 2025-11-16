# Multi-Factor Authentication MFA Google
Setting up and using multi-factor authentication (MFA) on your Linux servers is a highly effective security measure, especially for protecting SSH access. The most common and reliable method for setting up multi-factor authentication (MFA) is to use the Google Authenticator PAM module.

# Install Google Authenticator PAM:
```bash
sudo apt update
sudo apt install libpam-google-authenticator
sudo apt install qrencode
```
# User MFA Conf. and View:
```bash
google-authenticator
google-authenticator -t -d -f -r 3 -R 30 -W
```
```bash
1: "Do you want authentication tokens to be time-based?" (y)
2: QR Code
3: "Do you want me to update your ~/.google_authenticator file?" (y)
4: "Do you want to disallow multiple uses of the same authentication token?" (y)
5: "By default, tokens are good for 30 seconds..." (n)
6: "Do you want to enable rate-limiting?" (y)
```
# SSH için PAM Yapılandırması:
>File: sudo nano /etc/pam.d/sshd
```bash
auth required pam_google_authenticator.so # "This line should be above the @include common-auth line"
@include common-auth
```

# SSH Daemon Yapılandırması:
>File: sudo nano /etc/ssh/sshd_config
```bash
AuthenticationMethods publickey,keyboard-interactive # SSH Key + MFA
ChallengeResponseAuthentication yes
AuthenticationMethods keyboard-interactive # Password + MFA
PasswordAuthentication yes
UsePAM yes # Use PAM
```

# Sudo için MFA (Opsiyonel)
>File: sudo nano /etc/pam.d/sudo
```bash
auth required pam_google_authenticator.so
```

# SSH Service:
```bash
sudo systemctl restart ssh
sudo systemctl restart sshd
```
# Backup:
> You'll be provided with backup codes when setting up Google Authenticator. Keep these in a safe place.

> All suer ~/.google_authenticator file backup
```bash
cp ~/.google_authenticator ~/.google_authenticator.backup
```
