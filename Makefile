USR=king
NAME=chrome-novnc
TAG=amd64
IMG=${USR}/${NAME}:${TAG}

build: clean
	docker build --tag ${IMG} --no-cache     --build-arg="all_proxy=http://172.18.0.1:7890" \
                                               --build-arg="http_proxy=http://172.18.0.1:7890"  \
                                               --build-arg="https_proxy=http://172.18.0.1:7890"  \
                                               --progress=plain --network=host .

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker stop ${IMG} 2>/dev/null || :
	docker rm ${IMG} 2>/dev/null || :
	docker rmi ${IMG} 2>/dev/null || :
