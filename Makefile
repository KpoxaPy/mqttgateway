BIN = bin
BIN_NAME = mqttgateway

DOCKER_REPO = kpoxapy
DOCKER_IMAGE_NAME = mqttgateway
DOCKER_IMAGE_TAG = snapshot

.PHONY: all
all: build

$(BIN):
	mkdir $(BIN)

.PHONY: build
build $(BIN)/$(BIN_NAME): $(BIN) vendor
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $(BIN)/$(BIN_NAME)

.PHONY: docker-build
docker-build: 
	docker build -t "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" \
		-f Dockerfile \
		--build-arg ARCH="amd64" \
		--build-arg OS="linux" \
		./

.PHONY: docker-publish
docker-publish: $(PUBLISH_DOCKER_ARCHS)
	docker tag "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):latest"
	docker push "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)"
	docker push "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):latest"

vendor:
	export GO111MODULE=on && go mod init && go mod vendor
