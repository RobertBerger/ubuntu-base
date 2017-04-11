set -x
docker images
docker tag reslocal/ubuntu-base:latest reliableembeddedsystems/ubuntu-base:latest
docker images
docker login --username reliableembeddedsystems
docker push reliableembeddedsystems/ubuntu-base:latest
set +x