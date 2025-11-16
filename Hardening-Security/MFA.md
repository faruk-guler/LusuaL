# Multi-Factor Authentication MFA Google



>> sudo nano /etc/ssh/sshd_config
```bash
AuthenticationMethods publickey,keyboard-interactive
AuthenticationMethods publickey,keyboard-interactive:pam
AuthenticationMethods publickey,keyboard-interactive
```

