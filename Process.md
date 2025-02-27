# Deamons / Services / Process

```bash
# SERVICES / DAEMONS ----------------------------------------------
# List all
systemctl status

# One service
systemctl status <service>
systemctl stop <service>
systemctl start <service>

# Enabled to start at boot time
systemctl disable <service>
systemctl enable <service>

# Service scripts
less /etc/systemd/system/multi-user.target.wants/docker.service

# PROCESSES ------------------------------------------------------
# Display your currently running processes
ps

# Display all the currently running processes on the system.
# https://www.cyberciti.biz/faq/find-out-what-processes-are-running-in-the-background-on-linux/
# STAT: D unstoppable | Idle | Running | Stoppable | sTopped | Zombie
ps -ef
ps -aux

# List with an specific STAT
ps [STAT]
ps r

# Display process information for processname
ps -ef | grep <processname>
ps -eo pid,user,stat,comm | grep <processname>

# Display and manage the top processes
top

# Interactive process viewer (top alternative)
htop

# Terminate / Kill process with process ID of pid
kill <pid>
kill -9 <pid>

# Kill all processes named processname
killall <processname>

# Send to background
<program> [> /tmp/file 2> /tmp/file.error] &
nohup <program> &
Ctrl + Z

# Display stopped or background jobs
# of this terminal
jobs -l

# Brings the most recent background job to foreground
fg [n]

# If process output goes to file
tail -f /proc/<pid>/fd/1

# CRON ------------------------------------------------------
# https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804
# List jobs
crontab -l

# Edit jobs
crontab -e
cd /var/spool/cron/crontabs

# See logs
less /var/spool/mail/<user>
```
```bash
ps                    # Show active processes  
top                   # Show running processes in real-time  
kill pid              # Kill a process by ID  
pkill name            # Kill a process by name  
bg                    # Resume a suspended process in background  
fg                    # Bring a process to the foreground  
fg n                  # Bring job 'n' to foreground  
renice +n [pid]       # Change process priority  
ps -ef | grep <process>  
ps -ef --sort=-%cpu | head -10  
ps -ef --sort=-%mem | head -10  
pstree  

ps                      # Display your currently active process
ps aux | grep 'telnet'  # Find all process id's related to telnet process
pmap                    # Memory map of process
top                     # Display all running processes
kill pid                # Kill process with mentioned pid id
killall proc            # Kill all processes named proc
pkill process-name      # Send signal to a process with its name
bg                      # Resumes suspended jobs without bringing them to the foreground
fg                      # Brings the most recent job to the foreground
fg n                    # Brings job n to the foreground
```
