FROM kaktuss/essi:0.28

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV CONSUL_HTTP_ADDR=
ENV CONSUL_TOKEN=
ENV VAULT_ADDR=
ENV VAULT_TOKEN=

COPY generate.sh.template /root/generate.sh.template
COPY key.template /root/key.template
COPY config.template /root/config.template
COPY consul-template_0.15.0_SHA256SUMS /usr/local/bin/consul-template_0.15.0_SHA256SUMS
COPY start.sh /usr/local/bin/start.sh

RUN \
  apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y curl unzip \

  && cd /usr/local/bin \

  && curl -L https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip -o consul-template_0.15.0_linux_amd64.zip \
  && sha256sum -c consul-template_0.15.0_SHA256SUMS \
  && unzip consul-template_0.15.0_linux_amd64.zip \
  && rm consul-template_0.15.0_linux_amd64.zip consul-template_0.15.0_SHA256SUMS \

  && rm -rf /var/lib/apt/lists/*

CMD ["/usr/local/bin/start.sh"]
