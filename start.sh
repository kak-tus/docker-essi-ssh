#!/usr/bin/env sh

consul-template -once -template="/root/generate.sh.template:/root/generate.sh" \
  && chmod +x /root/generate.sh \
  && /root/generate.sh \
  && consul-template -once -template="/root/config.template:/home/www-data/.ssh/config" \
  && chmod 600 /home/www-data/.ssh/* \
  && chown -R www-data:www-data /home/www-data/.ssh \
  && /usr/local/bin/start_essi.sh
