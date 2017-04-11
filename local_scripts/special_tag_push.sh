if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "./special_tag_push.sh <tag>"
    exit
fi

set -x
docker images
docker tag reslocal/ubuntu-base:latest reliableembeddedsystems/ubuntu-base:$1
docker images
docker login --username reliableembeddedsystems
docker push reliableembeddedsystems/ubuntu-base:$1
set +x
