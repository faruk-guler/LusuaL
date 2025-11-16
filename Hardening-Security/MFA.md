# Google MFA (Multi-Factor Authentication) on Linux
Setting up and using multi-factor authentication (MFA) on your Linux servers is a highly effective security measure, especially for protecting SSH access. The most common and reliable method for setting up multi-factor authentication (MFA) is to use the Google Authenticator PAM module.

# Install Google Authenticator PAM:
```bash
# Debian:
sudo apt install libpam-google-authenticator
sudo apt install qrencode

# RHEL:
sudo dnf install epel-release
sudo dnf install google-authenticator qrencode
```
# Users MFA Conf. and View:
```bash
google-authenticator

cat ~/.google_authenticator
qrencode -t ansiutf8 < ~/.google_authenticator
```
```bash
1: "Do you want authentication tokens to be time-based?" (y)
2: "QR Code"
3: "Do you want me to update your ~/.google_authenticator file?" (y)
4: "Do you want to disallow multiple uses of the same authentication token?" (y)
5: "By default, tokens are good for 30 seconds..." (n)
6: "Do you want to enable rate-limiting?" (y)
```
> These steps are done for all users.
# Configure PAM to Use Google Authenticator:
>File: sudo nano /etc/pam.d/sshd
```bash
auth required pam_google_authenticator.so nullok # nullok: Allows login without MFA to users who have not yet set up TOTP.
auth required pam_google_authenticator.so        # "This line should be above the @include common-auth line"
# @include common-auth                           # Traditional password authentication
```

# Configure SSH for MFA:
>File: sudo nano /etc/ssh/sshd_config
```bash
	
AuthenticationMethods publickey,keyboard-interactive # SSH Key + MFA
ChallengeResponseAuthentication yes
AuthenticationMethods keyboard-interactive           # Password + MFA
AuthenticationMethods publickey,password publickey,keyboard-interactive
KbdInteractiveAuthentication yes
PasswordAuthentication yes
UsePAM yes                                           # Use PAM
```
# Sudo for MFA (Optional)
> File: sudo nano /etc/pam.d/sudo
```bash
auth required pam_google_authenticator.so
```

# SSH Service:
```bash
sudo systemctl enable ssh
sudo systemctl start ssh
# sudo systemctl stop ssh
sudo systemctl restart ssh
```
# Alternative Verification Methods:
> For those who prefer not to use their phone, there are also solutions:
- KeePassXC (desktop-based TOTP generator)
- Linux Authenticator App
- Firefox Authenticator plugin
> This allows you to generate verification codes without a mobile device."

# Backup:
> You'll be provided with backup codes when setting up Google Authenticator. Keep these in a safe place.

> all user ~/.google_authenticator file backup
```bash
cp ~/.google_authenticator ~/.google_authenticator.backup
chmod 600 ~/.google_authenticator.backup
```
# Rollback and Recovery:
```bash
- Temporarily renaming the google_authenticator file will disable MFA for that user.
- Remove TOTP line from /etc/pam.d/sshd or add nullok, set ChallengeResponseAuthentication to no in sshd_config
```
Author: faruk-guler www.farukguler.com
