# Contao Docker Container

* Based on CentOS 7
* Apache 2.4 (event)
* PHP 7.2
* Preinstalled composer
* Auto-adjust `DocumentRoot` for Contao 4
* Configured for [Contao CMS](https://www.contao.org)
* Ability to change UID of Apache
* Init system based on [S6](http://skarnet.org/software/s6/)
* Includes some useful tools and presets like git, curl, bashrc and vimrc
* Xdebug (disabled by default), Imagemagick, php-(bcmath,intl,json,mbstring,mcrypt,mysql,snmp,soap,xml)

## Usage

```
// Start MySQL/MariaDB first
sudo docker run --rm --name mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -v $HOME/contao/_db:/var/lib/mysql \
  mariadb

// take contao installation from $HOME/contao/contao
sudo docker run --rm --name contao \
  -v $HOME/contao/contao:/var/www \
  --link mysql:mysql \
  -p 80:80 \
  -e RUN_UID=$UID \
  -e XDEBUG=true \
  -e PHP_VALUE=max_execution_time=90,memory_limit=512M \
  psitrax/contao

// enter the Container
sudo docker exec -ti contao bash
root at 53e71dbf4adc in ~ su apache
root at 53e71dbf4adc in /var/www ~ composer create-project contao/standard-edition website

// if permission problems occour change owner
root at 53e71dbf4adc in ~ chown -R apache /var/www

// or managed edition
root at 53e71dbf4adc in /var/www ~ composer create-project contao/managed-edition website

root at 53e71dbf4adc in /var/www ~ mv website/* website/.gitignore .
// Restart Container to detect Contao 4
```

## Configuration

Use Environment Variables for Configuration

* `TIMEZONE=America/New_York` Adjust the timezone (Default: Europe/Berlin)
* `RUN_ID` The UID of internal `apache` User. Set it to your local UID to prevent file access problmes while developing.
* `XDEBUG=true` Enable xdebug (disabled by default)
* `PHP_VALUE` / `PHP_ADMIN_VALUE` Overwrite arbitrary PHP settings: eg `max_execution_time=90,memory_limit=512M`


## Maintainer

* Christoph Wiechert <wio@psitrax.de>
