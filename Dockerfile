FROM ubuntu:jammy

ENV QBITTORRENT_SIG_KEY=401E8827DA4E93E44C7D01E6D35164147CA69FC4
SHELL ["/bin/bash", "-c"] 

RUN groupadd --gid 1000 torrent \
&& useradd -d /home/torrent -ms /bin/bash --system --gid 1000 --uid 1000 torrent \
&& mkdir -p /downloads \
&& chown torrent:torrent /downloads

RUN apt-get update \
&& apt-get install -y gpg \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${QBITTORRENT_SIG_KEY} \
&& source /etc/lsb-release \
&& echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu ${DISTRIB_CODENAME} main" >> /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y curl tini qbittorrent-nox python3 \
&& apt-get remove -y gpg \
&& apt-get auto-remove -y \
&& apt-get clean  \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

USER torrent

EXPOSE 8080
VOLUME /home/torrent /downloads
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s CMD curl --fail -I -L 'http://127.0.0.1:8080' || exit 1

ENTRYPOINT ["tini","--","/bin/entrypoint.sh"]
