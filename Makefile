BIN_DIR=$$(pwd)/../hackatron-bin/
IMAGE=paralin/hackatron
VERSION=latest

all:

build:
	meteor build $(BIN_DIR) --directory --server-only

docker: build
	cp ./private/docker/Dockerfile $(BIN_DIR)/Dockerfile
	cd $(BIN_DIR) && docker build -t "$(IMAGE):$(VERSION)" .

push: docker
	# docker tag $(IMAGE):$(VERSION) registry.etc.com/$(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
