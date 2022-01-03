# QBITTORRENT Container
![pipeline status](https://gitlab.com/chimbosonic/qbittorrent-container/badges/master/pipeline.svg)

This is a qbittorrent container with qbittorrent-nox from https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable.

Base image is ubuntu:latest.

The image is available on Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/qbittorrent)

Source code and pipeline can be found [here](https://gitlab.com/chimbosonic/qbittorrent-container)

## Running it
### plain docker
Feel free to change the port and folder that contains your config and downloads.

```bash
docker run -it --rm -p 8080:8080 -v "config_dir:/home/torrent" -v "dowload_dir:/downloads" --name qbittorrent -t chimbosonic/qbittorrent:latest
```

### docker-compose
```yml
qbittorrent:
    container_name: qbittorrent
    image: chimbosonic/qbittorrent:latest
    ports:
      - "52000:52000/tcp" # Bittorrent Port Set in WebUI
      - "52000:52000/udp" # Bittorrent Port Set in WebUI
      - "8080:8080/tcp" # Qbittorrent WebUI port
    volumes:
      - "config_dir:/home/torrent"
      - "dowload_dir:/downloads"
    restart: always
```

### How to build
This will build the container.

```bash
make build
```
