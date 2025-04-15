# Docker Dynamic-Inventory-Script -It automatically retrieves Docker container names and converts them into inventory.
# dynamic-hosts-docker.py
#!/usr/bin/env python3
import subprocess

# Docker container isimlerini al
containers = subprocess.check_output(['docker', 'ps', '--format', '{{.Names}}']).decode().splitlines()

# docker-hosts dosyasını oluştur
with open('docker-hosts', 'w') as file:
    file.write('[docker-containers]\n')
    for container in containers:
        file.write(f'{container}\n')
        
