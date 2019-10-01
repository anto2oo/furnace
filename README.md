# furnace

furnace is a collection of shell scripts that allows you to easily configure a LEMP stack under CentOS 7.

## Requirements
- CentOS 7
- Bash

## Installation

```
git clone https://github.com/anto2oo/furnace
cd furnace && ./configure
```

You may have to restart your computer or shell after finishing the install.

## Usage

furnace is subdivided in different modules that are :
- user
- website
- database
- mail
- ssl

### User management

Furnace uses standard UNIX users for its user management. Each user you create will get a home directory in /home/.
However, when you list users, only users that belong to the furnace group will show up.

#### Examples
- User creation :
```bash
furnace user add --username (USERNAME) --password (PASSWORD)
```

- User list : 
```bash
furnace user list
```

### Web hosting management (Apache2 + php-fpm)

You can add virtual hosts to an user. Only hostname virtual hosts are supported, which means you'll have to point the chosen domain to the appropriate server.
If you wish to enable phpMyAdmin and Roundcube on the domain, use the ```--allow-web-services``` flag when creating the virtual host

#### Examples
- Create a new virtual host :
```bash
furnace website add --username (USERNAME) --domain (EXAMPLE.ORG)
```

### Email management (Postfix + Dovecot)

Mail management can be tricky because it heavily relies on the DNS system to authenticate domains.
While furnace manages the server part of the emailing system, you'll need to setup manually the DNS part.
To help you, dummy DNS zones are stored into /usr/share/furnace/dns/

#### Examples 

- Add a domain for emailing :
```bash
furnace mail domainadd --domain (EXAMPLE.ORG)
```

- Add an email address to that domain :
```bash
furnace mail add --address (HELLO@EXAMPLE.ORG) --password (PASSWORD)
```
**Note** : hello@example.org will now be able to login to Roundcube.

### Database management (MySQL)

Furnace installs by default MariaDB and phpMyAdmin to manage your database. 
You can then create SQL users and databases with the db and db_usr modules.

#### Examples
- SQL user creation :
```bash
furnace database useradd --username (USERNAME) --password (PASSWORD)
```
- Database creation :
```bash
furnace database add --username (SQL USER) --database (DATABASE NAME)
```

### 