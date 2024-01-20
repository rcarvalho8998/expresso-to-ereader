#!/bin/sh

# We need to setup the env variables and permission for the regular
# user to use the crontab and call the scripts it wants.
printenv | grep -v "no_proxy" > /etc/environment # Used to allow crontab to access the environment variables

chmod +x /etc/cron.d/calibre-cron
chmod +x /scripts/ebook-download-script.sh
username=$(getent passwd $PUID | awk -F':' '{ print $1 }') #Get the username from the defined PUID | This does not work as it get the kasm-user the abc user is currently 911, it only becomes $PUID after this script runs.
echo "$username\nabc\nroot\n" > /etc/cron.allow #Adding permissions to the user, abc and root to run.
usermod -a -G crontab $username #Adding the user to the crontab group
usermod -a -G crontab abc #Adding the user to the crontab group
crontab -u $username /etc/cron.d/calibre-cron # Run crontab as the user