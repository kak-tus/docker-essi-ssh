FROM kaktuss/essi:0.30

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV CONSUL_TEMPLATE_VERSION=0.18.1

COPY consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS /usr/local/bin/consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS

RUN \
  apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y curl unzip \

  && cd /usr/local/bin \
  && curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
  && sha256sum -c consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS \
  && unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
  && rm consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS \

  && rm -rf /var/lib/apt/lists/*

ENV CONSUL_HTTP_ADDR=
ENV CONSUL_TOKEN=
ENV VAULT_ADDR=
ENV VAULT_TOKEN=

COPY config.template /root/config.template
COPY start.sh /usr/local/bin/start.sh
COPY store.sh /usr/local/bin/store.sh
COPY essi.hcl /etc/essi.hcl
COPY init_hosts.sh.template /root/init_hosts.sh.template

CMD consul-template -config /etc/essi.hcl
