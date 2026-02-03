Deploy JS app
=========

This role is helping developpers to auto deploy their applications from code repository to domain + ssl configurations

Requirements
------------

- **Ansible**: 2.10.0+
- **Target OS**: Ubuntu >= 22.04
- **Gitlabrunner**: 4.x installed on target hosts
- **Nginx**: Latest version
- **Privileges**: sudo/root access on managed nodes


Role Variables
--------------

We need a file here

**VAR Files**
```yaml
---
  project_directory_name: 
    - repository: git@gitlab.com:group/repository.git
      branch_work: dev
      runner: project_name-2
      service_name: mon-garagiste-api
      git_username: your_gitlab_useranem
      git_email: mon_email_prod@domain.com
      ports: 8399
      remote_db: false
      db_image: postgres:15
      db_port: 5432
      db_dynamc_port: 8398
      network_name: project_name
      db_password: 
      db_user: mon_garagistes
      db_volume: psql-data
      db_database: mon_garagistes
      db_container: repository_db
      db_host: 
      app_port: 3000
      database_url: postgresql://mon_garagistes:@localhost:5432/mon_garagistes
      
      
  project_name: project_name
  clone_directory: mon-garagiste-api
  private_key: /home/debian/.ssh/id_rsa
  network_name: project_name

  TYPE_PROJECT: nestjs
  ENV: production
  NODE_VERSION: 20

  server_blocks:
    - server_name: api.project_name.domain.com
      port: 8399
      email: mon_email_prod@domain.com

  runner_config_settings:
    - gitlab_url: "https://gitlab.com/"
      gitlab_runner_token: ""
      runner_description: "project_name-runner"
      runner_tags: "project_name"

```
Dependencies
------------

No dependecies roles

## Usage

### Basic Playbook

```yaml
---
- hosts: preprod_server
  become: true
  roles:
    - role: grc24.deploy_js_app
```

### Inventory 

```bash
  [preprod]
  domain.com

  [preprod:vars]
  ansible_user=debian
  ansible_password=
  ansible_become_password=
  ansible_connection=ssh
  ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

### Testing

```bash
nano variables_files.yaml
ansible-playbook -i inventory playbook.yml -e "@variables_files.yaml"
```
License
-------

BSD

Author Information
------------------

SEIDOU DAVID | DevOps & Cloud | seidoudavid97@gmail.com