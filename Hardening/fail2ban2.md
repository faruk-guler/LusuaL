# fail2ban

## Installation - Ubuntu / Debian

```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install fail2ban
```

### Installation FreeBSD

```sh
sudo pkg install py37-fail2ban
```

## Configuration

## Configuration Ubuntu / Devian

```sh
cd /etc/fail2ban
sudo vi jail.local
```

This configuration is for the sshd daemon. If a user fails to connect three times (maxretry = 3) within 24 hours (findtime = 24h) to login via ssh, he will get banned indefinitely (bantime = -1). 

```
#
# SSH servers
#

[sshd]
enabled = true
filter = sshd
# To use more aggressive sshd modes set filter parameter "mode" in jail.local:
# normal (default), ddos, extra or aggressive (combines all).
# See "tests/files/logs/sshd" or "filter.d/sshd.conf" for usage example and details.
mode   = aggressive
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
banaction = iptables-multiport
bantime = -1
maxretry = 3
findtime = 24h
```

### Configuration FreeBSD

in `/usr/local/etc/fail2ban/jail.d/bsd-sshd.conf`

```
[bsd-ssh-pf]
enabled = true
filter = bsd-sshd
port = ssh
logpath = /var/log/auth.log
#findtime = 600
#maxretry = 3
#bantime  = 86400
findtime = 24h
maxretry = 3

bantime  = 86400
```

## List banned IPs

### Via fail2ban-client

```sh
sudo fail2ban-client status <jail name>
```

```sh
sudo fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed:	2
|  |- Total failed:	5
|  `- File list:	/var/log/auth.log
`- Actions
   |- Currently banned:	2
   |- Total banned:	2
   `- Banned IP list:	89.208.197.76 92.222.88.254
```

### via iptables

```sh
sudo iptables --list --line-numbers --numeric
```

```sh
sudo iptables --list --line-numbers --numeric
Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    f2b-sshd   tcp  --  0.0.0.0/0            0.0.0.0/0            multiport dports 22

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain f2b-sshd (1 references)
num  target     prot opt source               destination         
1    REJECT     all  --  92.222.88.254        0.0.0.0/0            reject-with icmp-port-unreachable
2    REJECT     all  --  89.208.197.76        0.0.0.0/0            reject-with icmp-port-unreachable
3    RETURN     all  --  0.0.0.0/0            0.0.0.0/0           
```

### vi 'pfctl' - FreeBSD

```sh
sudo pfctl -a "f2b/bsd-ssh-pf" -t f2b-bsd-ssh-pf -Ts
   118.27.6.66
   165.227.30.198
   209.141.55.11
```

## Ban and unban manually

### Ban

```sh
sudo fail2ban-client set <JAIL> banip <IP>
```

### Unban

```sh
sudo fail2ban-client unban <IP>
```

## Test the filter

```sh
fail2ban-regex <logfile> <failregex> <ignoreregex>
```

I had some trouble with banning IPs. Therefore I've greped the IP and put it into a file

```sh
sudo grep 92.222.88.254 auth.log > /tmp/test.log
```

And test it with

```sh
sudo fail2ban-regex /tmp/test.log /etc/fail2ban/filter.d/sshd.conf 

Running tests
=============

Use   failregex filter file : sshd, basedir: /etc/fail2ban
Use         maxlines : 1
Use      datepattern : Default Detectors
Use         log file : /tmp/test.log
Use         encoding : UTF-8


Results
=======

Failregex: 53 total
|-  #) [# of hits] regular expression
|   8) [53] ^User <F-USER>.+</F-USER> from <HOST> not allowed because listed in DenyUsers\s*(?: \[preauth\])?\s*$
`-

Ignoreregex: 0 total

Date template hits:
|- [# of hits] date format
|  [222] {^LN-BEG}(?:DAY )?MON Day %k:Minute:Second(?:\.Microseconds)?(?: ExYear)?
`-

Lines: 222 lines, 0 ignored, 53 matched, 169 missed
[processed in 1.53 sec]

Missed line(s): too many to print.  Use --print-all-missed to print all 169 lines
```

**The *Failregex: 53 total* is the relevant line.**

Here is an example with an IP that wasn't recognized by the filter

```sh
sudo grep 222.186.30.218 /var/log/auth.log > /tmp/test1.log
```

```sh
sudo fail2ban-regex /tmp/test1.log /etc/fail2ban/filter.d/sshd.conf 

Running tests
=============

Use   failregex filter file : sshd, basedir: /etc/fail2ban
Use         maxlines : 1
Use      datepattern : Default Detectors
Use         log file : /tmp/test1.log
Use         encoding : UTF-8


Results
=======

Failregex: 0 total

Ignoreregex: 0 total

Date template hits:
|- [# of hits] date format
|  [3] {^LN-BEG}(?:DAY )?MON Day %k:Minute:Second(?:\.Microseconds)?(?: ExYear)?
`-

Lines: 3 lines, 0 ignored, 0 matched, 3 missed
[processed in 0.12 sec]

|- Missed line(s):
|  Apr 22 16:01:02 raspberrypi sshd[14285]: Received disconnect from 222.186.30.218 port 63194:11:  [preauth]
|  Apr 22 16:01:02 raspberrypi sshd[14285]: Disconnected from 222.186.30.218 port 63194 [preauth]
```

## Links
* [Proper fail2ban configuration](https://github.com/fail2ban/fail2ban/wiki/Proper-fail2ban-configuration)
* [Troubleshooting fail2ban](https://github.com/fail2ban/fail2ban/wiki/Troubleshooting)
* [How to Setup Fail2ban on the Raspberry Pi](https://pimylifeup.com/raspberry-pi-fail2ban/)
* [How To Protect SSH With Fail2Ban on CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-centos-7)
* [How to get list banned ip and its unban time in fail2ban on Linux?](https://superuser.com/questions/1539368/how-to-get-list-banned-ip-and-its-unban-time-in-fail2ban-on-linux)
* [Optimising your Fail2Ban filters](https://www.the-art-of-web.com/system/fail2ban-filters/)