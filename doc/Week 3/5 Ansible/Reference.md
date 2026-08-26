# Ansible Reference Guide

A concise reference for Ansible’s core abstractions: Roles, Variables, Templates, Vault, and Galaxy.

---

## 1. Roles

Roles provide a standardized file layout to organize playbooks into reusable components.

Directory structure:
```

roles/
└── my_role/
├── defaults/       # default variables (lowest precedence)
│   └── main.yml
├── vars/           # static variables (higher precedence)
│   └── main.yml
├── tasks/          # ordered list of tasks
│   └── main.yml
├── handlers/       # handlers triggered by notify
│   └── main.yml
├── templates/      # Jinja2 templates
│   └── conf.j2
├── files/          # static files to copy
│   └── logo.png
├── meta/           # role metadata (dependencies)
│   └── main.yml
└── README.md       # role documentation
```
Use a role in a playbook:
```
yaml
- hosts: all
  roles:
    - role: my_role
      vars:
      custom_var: "value"
```
---

## 2. Variables

Ansible variables can be defined in many places, with the following precedence (lowest → highest):

1. role defaults  
2. inventory vars  
3. playbook vars  
4. host_vars / group_vars  
5. extra-vars (`-e`)

Example definitions:

- **Inventory** (`inventory.ini`):
  ```ini
  [web]
  web1 ansible_host=192.0.2.10 my_var=foo
  ```

- **Playbook vars**:
  ```yaml
  - hosts: web
    vars:
      package_name: nginx
  ```

- **Host/group vars** (`group_vars/web.yml`):
  ```yaml
  pkg_version: "1.18.0"
  ```

- **Extra-vars** (CLI):
  ```bash
  ansible-playbook site.yml -e "debug=true"
  ```

Use in tasks:
```
yaml
- name: Install package
  apt:
    name: "{{ package_name }}={{ pkg_version }}"
    state: present
```
---

## 3. Templates

Jinja2 templates render dynamic configuration files.

- **Template file** (`templates/nginx.conf.j2`):
  ```jinja
  user www-data;
  worker_processes auto;
  pid /run/nginx.pid;
  events { worker_connections 1024; }

  http {
    server {
      listen 80;
      server_name {{ ansible_fqdn }};
      root {{ doc_root }};
    }
  }
  ```

- **Task to render**:
  ```yaml
  - name: Deploy NGINX config
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify: restart nginx
  ```

Template variables come from playbook vars, inventory, host/group vars, or defaults.

---

## 4. Vault

Ansible Vault encrypts sensitive data in YAML:

- **Create a vault file**:
  ```bash
  ansible-vault create group_vars/all/vault.yml
  ```
- **Edit**:
  ```bash
  ansible-vault edit group_vars/all/vault.yml
  ```
- **Usage** in playbook:
  ```yaml
  vars_files:
    - group_vars/all/vault.yml
  ```
- **Run with password prompt**:
  ```bash
  ansible-playbook site.yml --ask-vault-pass
  ```
- **Run with vault password file**:
  ```bash
  ansible-playbook site.yml --vault-password-file ~/.vault_pass.txt
  ```

---

## 5. Galaxy

Ansible Galaxy is a repository for sharing roles and collections.

- **Install a role**:
  ```bash
  ansible-galaxy install geerlingguy.nginx
  ```
- **Install from requirements** (`requirements.yml`):
  ```yaml
  ---
  roles:
    - name: geerlingguy.redis
      version: 4.0.0
  collections:
    - name: community.general
      version: 5.2.0
  ```
  ```bash
  ansible-galaxy install -r requirements.yml
  ansible-galaxy collection install -r requirements.yml
  ```
- **Init a new role**:
  ```bash
  ansible-galaxy init my_role
  ```

Use Galaxy roles in your playbooks just like local roles.

---

# Quick CLI Cheatsheet

- `ansible all -m ping -i inventory.ini`
- `ansible-playbook site.yml -i inventory.ini`
- `ansible-doc <module>`
- `ansible-lint site.yml`
- `ansible-galaxy install <role>`
- `ansible-vault encrypt <file>`
- `ansible-vault decrypt <file>`

---

This reference summarizes Ansible’s building blocks—roles, variables, templates, vault, and Galaxy—to help you modularize, secure, and share your automation.
