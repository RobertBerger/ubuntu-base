docker images
docker tag reslocal/ubuntu-base:latest reliableembeddedsystems/ubuntu-base:latest
docker login --username reliableembeddedsystems
docker images
docker push reliableembeddedsystems/ubuntu-base:latest
