# Switch PHP versions
phpv() {
    if [ $1 = "8.5" ]; then
        valet use php
    else
        valet use php@$1
    fi
    sed -in "s/128M/512M/g" /opt/homebrew/etc/php/$1/conf.d/php-memory-limits.ini
    composer global update
    source ~/.zshrc
}

alias php82="phpv 8.2"
alias php84="phpv 8.4"

xdebug() {
   php_version_dot=$(php -r "\$v=explode('.', PHP_VERSION ); echo implode('.', array_splice(\$v, 0, -1));")
   xendConfigFolder="/opt/homebrew/etc/php/$php_version_dot/conf.d"

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

install_xdebug() {
   php_version_dot=$(php -r "\$v=explode('.', PHP_VERSION ); echo implode('.', array_splice(\$v, 0, -1));")
   php_ini_file="/opt/homebrew/etc/php/$php_version_dot/php.ini"
   xendConfigFolder="/opt/homebrew/etc/php/$php_version_dot/conf.d"
   xdebugIniFile="$xendConfigFolder/ext-xdebug.ini"

   #Delete reference to xdebug from the php.ini file
   sed -in '/.*xdebug.*/d' $php_ini_file

   #Make a specific xdebug ini file for this php version
   echo "[xdebug]" >> $xdebugIniFile
   echo "zend_extension=xdebug" >> $xdebugIniFile
}

xdebug_listen() {
   if php -m | grep -q "Xdebug"; then
      export XDEBUG_MODE=debug XDEBUG_SESSION=1

      echo "Xdebug constants set"
   else
      echo "Xdebug is not enabled. Enable it first by running xdebug."
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
