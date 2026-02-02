Deploy JS app
=========

This role is helping developpers to auto deploy their applications from code repository to domain + ssl configurations

Requirements
------------

Need ansible to be install 
You need to :
* Install and configure Ansible
* Install and configure Gitlab runner
* Install and configure nginx reverse proxy

Role Variables
--------------

We need a file here

**VAR Files**
```bash
  project_directory_name: 
    - repository: git@gitlab.com:waouhmonde/repository.git
      branch_work: dev
      runner: project_name-2
      service_name: mon-garagiste-api
      git_username: waouhmonde_dav97
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

Example Playbook
----------------
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

License
-------

BSD

Author Information
------------------

SEIDOU DAVID - DevOps & Cloud