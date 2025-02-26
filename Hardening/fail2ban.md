###### Fail2ban setup:
```
sudo apt install fail2ban -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl start fail2ban (status|stop|restart)
systemctl enable fail2ban
fail2ban-client status
fail2ban-client status nginx-4xx

# Ban IP:
fail2ban-client set <jailname> banip <ip-address>

# Unban IP:
fail2ban-client set <jailname> unbanip <ip-address>


# nano /etc/fail2ban/filter.d/nginx-4xx.conf 
#
[Definition]
failregex = ^<HOST>.*"(GET|POST).*" (404|444|403|400) .*$
ignoreregex =


# nano /etc/fail2ban/jail.local
#
[sshd]
enabled = false

[nginx-4xx]
action = iptables-multiport[name="nginx_4xx", port="http,https"]
         sendmail-whois-custom[name="nginx_4xx", sender="no-reply@test.dev", dest="test@gmail.com, test1@gmail.com"]
enabled = true
filter = nginx-4xx
port = http,https
logpath = /var/log/nginx/access.log
findtime = 60
bantime = 60
maxretry = 10

# nano /etc/fail2ban/action.d/sendmail-whois-custom.conf
# Fail2Ban configuration file
#
# Author: Cyril Jaquier
#
#

[INCLUDES]

before = sendmail-common.conf

[Definition]

# bypass ban/unban for restored tickets
norestored = 1

# Option:  actionban
# Notes.:  command executed when banning an IP. Take care that the
#          command is executed with Fail2Ban user rights.
# Tags:    See jail.conf(5) man page
# Values:  CMD
#
actionban =   printf %%b "Subject:🕵️ [Fail2Ban] <name>: BANNED IP <ip>! 🔨
              Date: `LC_ALL=C date +"%%a, %%d %%h %%Y %%T %%z"`
              From: <sendername> <<sender>>
              To: <dest>\n
              Hi,\n
              The jail <name> has banned ip <ip> after <failures> attempts against <name>.\n
              Here is some info about the IP: https://db-ip.com/<ip> \n
              Lines containing IP <ip>: \n
              `grep '<ip>' <logpath>` \n
              Regards,\n
              Fail2Ban" | /usr/sbin/sendmail -f <sender> <dest>

actionunban = printf %%b "Subject:🔔 [Fail2Ban] <name>: UNBANNED IP <ip> ✅
              Date: `LC_ALL=C date +"%%a, %%d %%h %%Y %%T %%z"`
              From: <sendername> <<sender>>
              To: <dest>\n
              Hi,\n
              Fail2ban has unbanned ip https://db-ip.com/<ip> successfully. \n
              Regards,\n
              Fail2Ban" | /usr/sbin/sendmail -f <sender> <dest>

[Init]

# Default name of the chain
#
name = default

````

--------------------------------------------------------------------------------------------
###### Recommended iptables setup:
```
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport ssh -j ACCEPT
sudo iptables -A INPUT -p tcp --dport http -j ACCEPT
sudo iptables -A INPUT -p tcp --dport https -j ACCEPT
sudo iptables -P INPUT DROP
```

###### Persistent iprules from memory: 
```
sudo apt-get install -y iptables-persistent
sudo iptables-save | sudo tee /etc/iptables/rules.v4
sudo service netfilter-persistent start     # also use status/reload/stop
sudo invoke-rc.d netfilter-persistent save  # Add to startup
```

###### Check iptables:
```
sudo iptables -S
```

###### Restore those rules:
```
sudo iptables-restore < /etc/iptables/rules.v4
```

###### Check rules:
```
sudo iptables -L -v
```

###### Appending Rules:
```
sudo iptables -A INPUT -p tcp --dport ssh -j ACCEPT
```

###### Inserting Rules:
```
sudo iptables -I INPUT 4 -p tcp --dport http -j ACCEPT
```

###### Delete based on its position:
```
sudo iptables -D INPUT 4
```

###### Delete based on what the rule does:
```
sudo iptables -D INPUT -p tcp --dport 443 -j ACCEPT
```

###### Let's change the INPUT chain to default to DROP:
```
sudo iptables -P INPUT DROP
```

###### cool stuff
```
watch 'iptables -nvL'
```

###### Reset iptables:
```
sudo iptables -F
```

###### Delete iptables rule:
```
sudo iptables -L -n --line-numbers
sudo iptables -D f2b-nginx_4xx 1
```

----------------------------------------------------------------------------------------------------
###### Sendmail setup:
````
sudo apt-get install sendmail-bin sendmail -y
sudo nano /etc/hosts
127.0.0.1 localhost test.dev ubuntu
127.0.1.1 test.dev ubuntu
sudo sendmailconfig

echo "test message" | sendmail -v test1@gmail.com
```