.PHONY: test

IMAGE=kmbn/docker-compose:latest

build:
	docker build -t $(IMAGE) .

test:
	docker run $(IMAGE) docker -v
	docker run $(IMAGE) docker-compose -v

push:
	docker login
	docker push $(IMAGE)
