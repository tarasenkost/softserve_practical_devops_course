# Ansible Role: PostgreSQL Database Setup

A role that installs and configures PostgreSQL on a server. It allows you to specify the PostgreSQL version, create databases and users, and configure user privileges and authentication methods.

## Requirements

- Ansible 2.9 or higher.
- Ansible Collection: `community.postgresql` (ensure it's installed).
- The target host must be a Debian/Ubuntu-based system.
- Root or sudo privileges on the target host.

## Role Variables

The following variables can be customized as needed:

### Essential Variables

These variables must be defined for the role to work properly:

- `db_name`: **(Required)** The name of the database to create.

- `db_user`: **(Required)** The username to create.

- `db_pass`: **(Required)** The password for the user.

### Defaults (defaults/main.yml)

- `postgresql_options`: A list of PostgreSQL configuration options to set.

- `postgresql_databases`: A list of databases to create.

- `postgresql_users`: A list of users to create with associated passwords and databases.

- `postgresql_schemas`: A list of schemas to create.

- `postgresql_privs`: A list of privileges to set for users.

- `postgresql_hba_entries`: Host-based authentication entries for `pg_hba.conf`.


### Variables (vars/main.yml)

- `postgresql_version`: The version of PostgreSQL to install.

- `postgresql_config_dir`: The PostgreSQL configuration directory.

- `postgresql_daemon`: The name of the PostgreSQL service.

- `postgresql_system_user`: The system user under which PostgreSQL runs.

- `postgresql_system_group`: The system group under which PostgreSQL runs.

- `postgresql_auth_method`: The authentication method to use in `pg_hba.conf`.

- `postgresql_packages`: List of packages to install for PostgreSQL.

- `postgresql_python_library`: Python library required for PostgreSQL modules.


## Dependencies

This role does not have any dependencies on other roles.

**Note**: The following Ansible collection is required:
```bash
ansible-galaxy collection install community.postgresql
``` 
## Example Playbook

Here is an example of how to use this role:
```yml
  hosts: {your_db_host}
  roles:
    - db
```
## Author information
Created by Stas Tarasenko for SoftServe Practical DevOps Course.



