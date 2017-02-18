#!/usr/bin/env sh

mkdir -p /home/www-data/.ssh
chown -R www-data:www-data /home/www-data/.ssh
chmod 700 /home/www-data/.ssh
chmod 600 /home/www-data/.ssh/*

/usr/local/bin/start_essi.sh &
child=$!

sleep 10
/usr/local/bin/init_hosts.sh

trap "kill $child" TERM
wait "$child"
