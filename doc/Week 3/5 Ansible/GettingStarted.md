# Getting Started with Ansible

This guide walks you through installing Ansible on Windows and macOS, creating an inventory, writing your first playbook, and running it against a target host.

---

## 1. Ansible Control Node Installation

### 1.1 Windows (via WSL2)

1. **Enable WSL2**  
   - Open PowerShell as Administrator and run:  
     ```powershell
     wsl --install
     ```  
   - Reboot if prompted.

2. **Install Ubuntu (or Debian)** from Microsoft Store.  
3. **Open your WSL shell** and update packages:  
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

4. **Install Python & pip**:
   ```bash
   sudo apt install -y python3 python3-pip sshpass
   ```

5. **Install Ansible** via pip:
   ```bash
   pip3 install --user ansible
   ```

6. **Add Ansible to PATH** (if needed):
   ```bash
   echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
   source ~/.bashrc
   ```

7. **Verify**:
   ```bash
   ansible --version
   ```

---

### 1.2 macOS (Homebrew)

1. **Install Homebrew** (if not already):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Ansible**:
   ```bash
   brew update
   brew install ansible
   ```

3. **Verify**:
   ```bash
   ansible --version
   ```

---

## 2. Basic Inventory

Create a file named `inventory.ini`:
```
ini
[web]
web1.example.com ansible_user=ubuntu

[db]
db1.example.com ansible_user=ec2-user
```
- Replace hostnames with IPs or DNS names of your managed nodes.
- Ensure SSH key-based access is configured.

---

## 3. First Ad-Hoc Command

Ping all hosts:
```
bash
ansible all -i inventory.ini -m ping
```
Expected output:
```

web1.example.com | SUCCESS => { "ping": "pong" }
db1.example.com  | SUCCESS => { "ping": "pong" }
```
---

## 4. Hello-World Playbook

Create `site.yml`:
```
yaml
---
- name: Hello World Playbook
  hosts: web
  become: yes

  tasks:
    - name: Ensure NGINX is installed
      apt:
        name: nginx
        state: latest
        update_cache: yes

    - name: Start and enable NGINX
      service:
        name: nginx
        state: started
        enabled: yes
```
---

## 5. Run the Playbook
```
bash
ansible-playbook -i inventory.ini site.yml
```
You should see each task’s result (ok/changed) for each `web` host.

---

## 6. Next Steps

- **Roles**: break your playbooks into reusable roles under `roles/`.
- **Variables**: parameterize with `vars/`, `host_vars/`, and `group_vars/`.
- **Templates**: use Jinja2 templates in `templates/`.
- **Vault**: securely encrypt secrets with `ansible-vault`.
- **Galaxy**: discover community roles on [Ansible Galaxy](https://galaxy.ansible.com/).

---

Congratulations! You’ve installed Ansible, connected to hosts, and run your first playbook. Happy automation!
