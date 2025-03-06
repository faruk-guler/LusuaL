Define text editor
```
$ sudo update-alternatives --config editor
```

Edit `/etc/sudoers` file
```
$ sudo visudo /etc/sudoers
```

Add a user to sudo group
```
$ sudo usermod -aG sudo username
or
$ sudo gpasswd -a username sudo
```
(but CentOS uses "wheel" group instead)

Default config for Ubuntu 22:
```
# User privilege specification
root    ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
```

Remove login for default users:
```
$ usermod -s /usr/sbin/nologin username
```

Sources:

- https://www.sudo.ws/docs/man/1.8.17/sudoers.man
- https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file#user-privilege-lines
