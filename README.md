# QBITTORRENT Container
![pipeline status](https://gitlab.com/chimbosonic/qbittorrent-container/badges/master/pipeline.svg)

This is a qbittorrent container with qbittorrent-nox from https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable.

Base image is ubuntu:latest.

The image is available on Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/qbittorrent)

## Running it
### plain docker
Feel free to change the port and folder that contains your repos.

```bash
docker run -it --rm -p 8080:8080 -v "config_dir:/home/torrent" -v "dowload_dir:/downloads" --name qbittorrent -t chimbosonic/qbittorrent:latest
```

### docker-compose
Please read docker-compose.yml before running the following

```bash
docker-compose up -d
```

### How to build
This will build the container.

```bash
make build
```
