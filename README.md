# QBITTORRENT OCI image
![pipeline status](https://github.com/chimbosonic/qbittorrent-container/actions/workflows/main.yml/badge.svg?branch=main)

This is a qbittorrent OCI image built with qbittorrent-nox from https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable.

Base image is ubuntu:jammy.

The image can be pulled from the following repositories:
- Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/qbittorrent)
- Quay.io [here](https://quay.io/repository/chimbosonic/qbittorrent)

Source code and pipeline can be found [here](https://github.com/chimbosonic/qbittorrent-container)

## Image Verification
The image is signed using [cosign](https://github.com/sigstore/cosign) from sigstore.

You can verify the signature with:
```bash
cosign verify --key cosign.pub chimbosonic/qbittorrent:latest
```

## Running it
### plain docker
Feel free to change the port and folder that contains your config and downloads.

```bash
docker run -it --rm -p 8080:8080 -v "config_dir:/home/torrent" -v "dowload_dir:/downloads" --name qbittorrent chimbosonic/qbittorrent:latest
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
## Misc
Image used to be stored and built at https://gitlab.com/chimbosonic/qbittorrent-container that repo is now deprecated.
