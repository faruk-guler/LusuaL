# What is Ansible?

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/512px-Ansible_logo.svg.png" alt="Ansible Logo" width="220"/>
</p>

Ansible lets you perform configuration management, task automation, security/compliance tasks, orchestration, cloud provisioning, and application deployment easily and in an automated fashion. In simple terms, Ansible follows a master-slave architecture — you have an **Ansible control node**, where you will trigger and manage your jobs (playbooks), and **managed nodes**, the machines you want to run the playbooks on (inventory). 

- Ansible only needs **SSH** connectivity to establish connectivity to the managed nodes. For Windows, Ansible utilizes **WinRM**.
- Playbooks contain anything you want to perform on your managed nodes, such as:
  - Installing an application
  - Copying files
  - Ensuring config files are set up properly
  - Removing unwanted files
- You can use **inventory files** to specify the managed nodes where playbooks should run.

### Key Features:
✅ **Minimal dependencies** – Only requires **Python** and a few support libraries.  
✅ **Declarative language** – Uses **YAML** for playbooks.  
✅ **Idempotent** – Ensures no unintended changes when rerunning playbooks.  

To learn more, check out our [Ansible tutorial](#).  
