# **`find`**  
The `find` command searches for files and directories based on various criteria.

### **Syntax**  
```bash
find [path] [expression]
```

### **Examples**  

- **Find a file by name:**  
  ```bash
  find /home/user -name "filename.txt"
  ```

- **Find a file ignoring case:**  
  ```bash
  find /home/user -iname "filename.txt"
  ```

- **Find and delete files:**  
  ```bash
  find /home/user -type f -name "*.log" -delete
  ```

- **Find files modified in the last 7 days:**  
  ```bash
  find /home/user -mtime -7
  ```

- **Find empty directories:**  
  ```bash
  find /home/user -type d -empty
  ```

- **Find executable files:**  
  ```bash
  find / -executable
  ```

- **Find files with user write permissions:**  
  ```bash
  find / -perm -u=w
  ```

- **Find files with group write permissions:**  
  ```bash
  find / -perm -g=w
  ```

- **Find files with others write permissions:**  
  ```bash
  find / -perm -o=w
  ```

- **Find `.log` files in `/var/log` containing "root":**  
  ```bash
  find /var/log -type f -name "*.log" -exec grep "root" {} \;
  ```

- **Execute commands on found files:**  
  ```bash
  find . -exec date {} \;
  find . -exec id {} \;
  find . -exec uname {} \;
  ```

- **Find files with multiple patterns:**  
  ```bash
  find / -type f \( -name "*.log" -o -name "*ple" -o -name "*pass" \)
  ```

- **Find files with max depth:**  
  ```bash
  find / -maxdepth 2 -name "pass*"
  ```

- **Find writable, readable, and empty files:**  
  ```bash
  find / -writable
  find / -readable
  find / -empty
  ```

- **Find empty directories and files:**  
  ```bash
  find / -empty -type d
  find / -empty -type f
  ```

- **Find files with specific permissions:**  
  ```bash
  find /etc/ -perm 777
  ```

- **Ignore permission errors:**  
  ```bash
  find / -name "passwd" 2> /dev/null
  ```

- **Find files owned by a user:**  
  ```bash
  find / -user username
  ```

- **Find files and directories by name:**  
  ```bash
  find .
  find . -name "user"
  find . -name "user*"
  find / -name "data" -type f
  find / -name "data" -type d
  ```

- **Find files case-insensitively:**  
  ```bash
  find / -iname "user*"
  ```
  ```bash
find /hedef/dizin -name "dosya_adı"
find /home -iname "example"
find /var/log -name "*.log"
find /home -type d
find /var -type d -name "log"
find / -type f -size +100M
find /var/log -type f -mtime -7
find /var/log -type f -mtime +30
find /etc -atime -1
find /home -uid 1000
find /var/ -gid 33
find /usr/bin -type f -executable
find /home -type f -perm /u=w
find /h -type f -perm 0777
find /home -type f -perm 0777
find /etc -type f -name "config.yaml"
find /var/log -type f -exec grep -il "error" {} +
find /home -mmin -120
find /home -type f -mmin -120
find /home -newermt "2024-02-01"
find / -type f -perm 0777
find /usr/bin -type f -perm -u=x
find /home -type f -user faruk
find /var/www -group www-data
find /etc -type f -exec grep -H "password" {} +
find /usr -type l
find /var/log -type f -exec grep -il "hacked" {} +
find /home -type f -empty
find /var -type d -empty
find /home -iname "*.jpg"
find /home -type f -perm -002
find /usr/bin -type f -perm /u=s
find /var -type f -exec du -h {} + | sort -rh | head -5
  ```
