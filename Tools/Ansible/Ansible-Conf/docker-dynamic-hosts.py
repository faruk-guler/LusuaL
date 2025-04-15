# Docker Dynamic-Inventory-Script -It automatically retrieves Docker container names and converts them into inventory.
# Docker-Dynamic.py
#!/usr/bin/env python3
import json, subprocess

containers = subprocess.check_output(['docker', 'ps', '--format', '{{.Names}}']).decode().splitlines()

inventory = {
    "docker-containers": {
        "hosts": containers,
        "vars": {}
    }
}

print(json.dumps(inventory))
