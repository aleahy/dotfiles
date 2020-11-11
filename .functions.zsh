# Switch PHP versions
phpv() {
    if [ $1 = "7.4" ]; then
        valet use php
    else
        valet use php@$1
    fi
    sed -in "s/128M/512M/g" /usr/local/etc/php/$1/conf.d/php-memory-limits.ini
    composer global update
    source ~/.zshrc
}

alias php73="phpv 7.3"
alias php74="phpv 7.4"

xdebug() {
   php_version_dot=$(php -r "\$v=explode('.', PHP_VERSION ); echo implode('.', array_splice(\$v, 0, -1));")
   xendConfigFolder="/usr/local/etc/php/$php_version_dot/conf.d"

   xdebugUpdated=false

   restartServer=false
   if [[ $1 = "--restart" ]]; then
      restartServer=true
   fi

   if [[ -f $xendConfigFolder/ext-xdebug.ini ]];
   then
      echo "Disabling xdebug"
      mv $xendConfigFolder/ext-xdebug.ini $xendConfigFolder/ext-xdebug.ini.disabled
      xdebugUpdated=true
   elif [[ -f $xendConfigFolder/ext-xdebug.ini.disabled ]];
   then
      echo "Enabling xdebug"
      mv $xendConfigFolder/ext-xdebug.ini.disabled $xendConfigFolder/ext-xdebug.ini
      xdebugUpdated=true
   else
      echo "Could not find ext-xdebug in $xendConfigFolder"
   fi

   if [ $restartServer = true ] && [ $xdebugUpdated = true ]
   then
      echo "Restarting valet"
      valet restart
   fi

}

make_db() {
   if [ "$#" -eq "0" ]; then
      echo "Usage: make_db <database_name>"
   else
      mysql -u root -e "create database $1;"
      if [ "$?" -eq 0 ]; then
         echo "Database $1 created"
      fi
   fi
}