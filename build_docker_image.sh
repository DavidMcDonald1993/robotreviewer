#!/bin/bash 

# robotreviewer
ROBOTREVIEWER_IMAGE_NAME=davidmcdonald93/docker-remote:robotreviewer
ROBOTREVIEWER_BUILD_IMAGE_NAME=${ROBOTREVIEWER_IMAGE_NAME}-build

# build and tag build image
sudo docker build --target build-stage -t ${ROBOTREVIEWER_BUILD_IMAGE_NAME} .
# build and tag runtime image
sudo docker build -t ${ROBOTREVIEWER_IMAGE_NAME} .
# push runtime image
sudo docker push ${ROBOTREVIEWER_IMAGE_NAME}

# robotreviewer-bert
ROBOTREVIEWER_BERT_IMAGE_NAME=davidmcdonald93/docker-remote:robotreviewer-bert

# build and tag runtime image
sudo docker build -f bert/Dockerfile -t ${ROBOTREVIEWER_BERT_IMAGE_NAME} bert/
# push runtime image
sudo docker push ${ROBOTREVIEWER_BERT_IMAGE_NAME}

# remove all exited containers
sudo docker rm $(sudo docker ps --filter=status=exited --filter=status=created -q)

# remove all untagged images 
sudo docker rmi $(sudo docker images -a --filter=dangling=true -q)

