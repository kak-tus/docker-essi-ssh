#!/usr/bin/env sh

consul-template -once -template="/root/generate.sh.template:/root/generate.sh" \
  && chmod +x /root/generate.sh \
  && /root/generate.sh \
  && consul-template -once -template="/root/config.template:/root/.ssh/config" \
  && chmod 600 /root/.ssh/* \
  && /usr/local/bin/start_essi.sh
