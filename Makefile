PROJECT := qbittorrent-container
NAME   := $(PROJECT)
TAG    := dev-$$(git rev-parse --short HEAD)
IMG    := $(NAME):$(TAG)
LATEST := $(NAME):latest-dev
current_dir = $(shell pwd)

# Dockerfile ARGS
BUILD_DATE      := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
VCS_REF         := $(shell git rev-parse --short HEAD)


.PHONY: build force-build run clean run-bash

ARGS= -t $(IMG) --build-arg BUILD_DATE=$(BUILD_DATE) --build-arg VCS_REF=$(VCS_REF) .
BUILD=@docker build
TAGS=@docker tag $(IMG) $(LATEST)

build:
	$(BUILD) $(ARGS)
	$(TAGS)

force-build:
	$(BUILD) --no-cache $(ARGS)
	$(TAGS)

run:
	@docker run -it --rm -p 8080:8080 -v "$(current_dir)/config_dir:/home/torrent" -v "$(current_dir)/dowload_dir:/downloads" --name $(PROJECT) -t $(LATEST)

run-bash:
	@docker run -it --rm --entrypoint /bin/bash --name $(PROJECT)-t $(LATEST) 

clean:
	rm -rf config_dir dowload_dir

test-signing-blob: 
	mkdir -p /tmp/$(PROJECT)/
	vault kv get -field=key secrets/$(PROJECT)/cosign > /tmp/$(PROJECT)/cosign.key
	@COSIGN_PASSWORD=$(shell vault kv get -field=password secrets/$(PROJECT)/cosign) cosign sign-blob --key /tmp/$(PROJECT)/cosign.key ./README.md
	rm -rf /tmp/$(PROJECT)

test-signing-image: 
	mkdir -p /tmp/$(PROJECT)/
	vault kv get -field=key secrets/$(PROJECT)/cosign > /tmp/$(PROJECT)/cosign.key
	@COSIGN_PASSWORD=$(shell vault kv get -field=password secrets/$(PROJECT)/cosign) cosign sign --key /tmp/$(PROJECT)/cosign.key chimbosonic/cgit:latest
	rm -rf /tmp/$(PROJECT)