#!/usr/bin/env sh

mkdir -p /home/www-data/.ssh
chown www-data:www-data /home/www-data/.ssh
chmod 700 /home/www-data/.ssh

consul-template -once -template="/root/generate.sh.template:/root/generate.sh" \
  && chmod +x /root/generate.sh \
  && /root/generate.sh \
  && consul-template -once -template="/root/config.template:/home/www-data/.ssh/config" \
  && chown -R www-data:www-data /home/www-data/.ssh \
  && chmod 600 /home/www-data/.ssh/*

/usr/local/bin/start_essi.sh >/proc/1/fd/1 2>/proc/1/fd/2 &
child=$!

trap "kill $child" TERM
wait "$child"

