# HAProxy:
HAProxy, short for High Availability Proxy, is an open-source load balancer and reverse proxy software. It is used primarily to provide high performance, reliability, and scalability in web servers, API services, and microservices architectures.

## Install:
```sh
sudo apt update
sudo apt upgrade -y
apt show haproxy
sudo apt install haproxy
sudo apt install haproxy=3.2.\*
haproxy -v
sudo journalctl -u haproxy -f
```

## Services:
```sh
sudo systemctl enable haproxy
sudo systemctl start haproxy
sudo systemctl restart haproxy
```

## Configuration:

```sh
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
nano /etc/haproxy/haproxy.cfg
```
# Load Balancing Algorithms:
```sh
# Round Robin (default)
balance roundrobin

# Least Connection (to the server with the fewest connections)
balance leastconn

# Source IP Hash (requests from the same IP to the same server)
balance source

# URI Hash (same URLs to the same server)
balance uri

# Header Hash (based on a specific HTTP header)
balance hdr(User-Agent)
```

## Conf. File: [balance roundrobin]
```sh
frontend http_front
    bind *:80
    mode http

    # Domain bazlı ACL
    acl is_haliyikama hdr(host) -i haliyikama.com
    acl is_guler      hdr(host) -i guler.com

    use_backend haliyikama_backend if is_haliyikama
    use_backend guler_backend      if is_guler

    # Varsayılan (hiçbiri eşleşmezse)
    default_backend guler_backend

backend haliyikama_backend
    balance roundrobin
    option httpchk GET /
    server h1 192.168.1.11:80 check
    server h2 192.168.1.12:80 check
    server h3 192.168.1.13:80 check

backend guler_backend
    balance roundrobin
    option httpchk GET /
    server g1 192.168.1.21:80 check
    server g2 192.168.1.22:80 check
    server g3 192.168.1.23:80 check
    server g4 192.168.1.24:80 check
    server g5 192.168.1.25:80 check

```

## SSL Termination:
```sh
#>
frontend https_front
    bind *:443 ssl crt /etc/ssl/private/haproxy.pem
    default_backend http_back
#<

# Convert & Perm:
cat your_cert.crt your_key.key > /etc/ssl/private/haproxy.pem
chmod 600 /etc/ssl/private/example.com.pem
```

## HAProxy Statics GUI: [http://server_ip:8480/stats]
```sh
listen stats
    bind *:8404
    stats enable
    stats uri /
    stats refresh 10s
    stats admin if TRUE
    stats auth admin:parola123
```

## Conf. Validation:
```sh
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
sudo systemctl status haproxy
```

## Firewall:
```sh
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=8404/tcp
sudo firewall-cmd --reload

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
sudo ufw reload
```

# Syslog:
## Conf. File: /etc/rsyslog.d/49-haproxy.conf
```sh
> local0.* /var/log/haproxy.log
sudo systemctl enable --now rsyslog
sudo systemctl restart rsyslog
sudo systemctl status rsyslog
tail -f /var/log/haproxy.log
grep "503" /var/log/haproxy.log
```
```sh
        +-----------------+
Client →|   HAProxy LB    |→ Server 1 (192.168.1.101)
        | (Frontend:80)   |→ Server 2 (192.168.1.102)
        +-----------------+
```
# HAProxy Configuration File

The HAProxy configuration file (typically located at `/etc/haproxy/haproxy.cfg`) is the central file used to define how HAProxy operates. It controls load balancing, proxying, and health checking of backend servers, and is divided into several key sections. Each section has a distinct role in managing the behavior of HAProxy.

## Key Sections

### 1. **global**

The `global` section sets process-wide settings that affect logging, user privileges, maximum connections, and other low-level parameters.

Example:
```haproxy
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon
```

### 2. **defaults**

The `defaults` section specifies default parameters for all subsequent `frontend`, `backend`, and `listen` sections. This section covers settings like timeouts, logging, and error handling.

Example:
```haproxy
defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000ms
    timeout client  50000ms
    timeout server  50000ms
```

### 3. **frontend**

The `frontend` section defines how HAProxy listens for incoming client connections. It specifies the IP address, port, and ACLs (Access Control Lists) used to route requests.

Example:
```haproxy
frontend http-in
    bind *:80
    default_backend servers
```

### 4. **backend**

The `backend` section defines the real servers that will handle client requests. It includes load balancing algorithms, server health checks, and parameters that control how requests are distributed.

Example:
```haproxy
backend servers
    balance roundrobin
    server server1 192.168.1.101:80 check
    server server2 192.168.1.102:80 check
```

### 5. **listen**

The `listen` section is a combined `frontend` and `backend` definition. It is used when both roles are defined in a single block, often for simple setups.

Example:
```haproxy
listen stats
    bind *:1936
    mode http
    stats enable
    stats hide-version
    stats realm Haproxy\ Statistics
    stats uri /stats
```

## Additional Directives

- **ACLs and Use Backend Rules:**  
  ACLs can be used within frontend sections to decide which backend should serve the request. For example:
  ```haproxy
  acl is_static path_end .jpg .png .css .js
  use_backend static_servers if is_static
  ```

- **Logging and Error Handling:**  
  You can customize logging formats and define error pages.
  
- **Health Checks:**  
  Servers in backends can be configured with health check options (`check`, `inter`, etc.) to ensure they are responsive before routing traffic.

## Best Practices

- **Modular Configuration:**  
  Split your configuration into multiple files or use includes if the configuration grows large, for easier management.
- **Testing:**  
  Always test configuration changes using `haproxy -c -f /etc/haproxy/haproxy.cfg` to check for syntax errors.
- **Documentation:**  
  Refer to the official [HAProxy documentation](http://www.haproxy.org) for detailed explanations of every directive and advanced configuration options.
- **Security:**  
  Secure the stats socket and web interface with authentication and appropriate access controls.

## Conclusion

The HAProxy configuration file is a versatile and powerful way to control HAProxy’s behavior, enabling detailed management of load balancing, proxying, and health checking. By understanding and properly configuring sections such as `global`, `defaults`, `frontend`, `backend`, and `listen`, administrators can build robust, scalable, and secure HAProxy deployments that meet the needs of diverse network environments.

- https://www.haproxy.org/
- https://haproxy.debian.net/
- https://hub.docker.com/_/haproxy/
