############################################
# Firewalld
############################################

sudo dnf install firewalld
sudo systemctl status firewalld
firewalld-cmd --stat
sudo systemctl enable firewalld
sudo systemctl start firewalld
systemctl stop firewalld
systemctl restart firewalld

  

