#!/bin/bash -e
CONF_PATH=/home/torrent/.config/qBittorrent/



if [ ! -f ${CONF_PATH}/qBittorrent.conf ]
then
echo "Config file not found creating to bypass legal notice"
mkdir -p ${CONF_PATH}
cat >${CONF_PATH}/qBittorrent.conf <<EOL
[LegalNotice]
Accepted=true
EOL
fi


echo "Config file found starting qbittorrent-nox"
qbittorrent-nox