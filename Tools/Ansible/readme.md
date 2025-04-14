# What is Ansible?

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/512px-Ansible_logo.svg.png" alt="Ansible Logo" width="200"/>
</p>

Ansible lets you perform configuration management, task automation, security/compliance tasks, orchestration, cloud provisioning, and application deployment easily and in an automated fashion. In simple terms, Ansible follows a master-slave architecture — you have an **Ansible control node**, where you will trigger and manage your jobs (playbooks), and **managed nodes**, the machines you want to run the playbooks on (inventory). 

- Ansible only needs **SSH** connectivity to establish connectivity to the managed nodes. For Windows, Ansible utilizes **WinRM**.
---
ansible:
  key_features:
    - name: "Agentless"
      description: "Runs over SSH or WinRM, no additional software is installed on managed machines"
    
    - name: "YAML Based"
      description: "Playbooks are written in YAML format"
    
    - name: "Idempotent"
      description: "Even if the same playbook is run more than once, the final state of the system does not change"
    
    - name: "Modular Structure"
      description: "Provides fast automation with ready-to-use modules"
    
    - name: "Platform Independent"
      description: "Works with Linux, Windows, macOS, network devices and cloud services"

  architecture:
    components:
      - name: "Control Node"
        description: "Host machine where playbooks are run (must be Linux/Unix based)"
      
      - name: "Managed Nodes"
        description: "Servers managed with Ansible (Linux, Windows, network devices, etc.)"
      
      - name: "Inventory"
        description: "List of managed machines"
      
      - name: "Playbook"
        description: "YAML files that define automation tasks"
      
      - name: "Modules"
        description: "Predefined tasks (e.g. apt, yum, copy, file)"
        examples:
          - "apt"
          - "yum"
          - "copy"
          - "file"
          - "service"
          - "template"
- You can use **inventory files** to specify the managed nodes where playbooks should run.

### Key Features:
✅ **Minimal dependencies** – Only requires **Python** and a few support libraries.  
✅ **Declarative language** – Uses **YAML** for playbooks.  
✅ **Idempotent** – Ensures no unintended changes when rerunning playbooks.  

To learn more, check out our [Ansible tutorial](#).  
