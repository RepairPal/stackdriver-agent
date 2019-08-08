from ubuntu:16.04

RUN apt-get update && apt-get -y install --no-install-recommends \
    vim-tiny \
    iproute2 \
    curl \
    ca-certificates \
    lsb-release \
    gnupg2 \
  && update-alternatives --install /usr/bin/vim vim /usr/bin/vim.tiny 1 

RUN curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh && \
    bash install-monitoring-agent.sh && \
    apt-get autoclean && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY collectd-gcm.conf.tmpl /opt/stackdriver/collectd/etc/collectd-gcm.conf.tmpl
COPY collectd.conf.tmpl /opt/stackdriver/collectd/etc/collectd.conf.tmpl
COPY run-agent.sh /usr/bin/run-agent.sh
COPY configurator /opt/configurator

CMD ["run-agent.sh"]

