ubuntu-base
===========

Ubuntu base image for docker

default user:
username: genius
password: genius

tag: master

===========

docker tag local-image:tagname reliableembeddedsystems/ubuntu-base:tagname

REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
reslocal/ubuntu-base   latest              8e31fbfb66a3        3 minutes ago       650.1 MB

docker tag reslocal/ubuntu-base:latest reliableembeddedsystems/ubuntu-base:master

===========

docker login --username reliableembeddedsystems

docker push reliableembeddedsystems/ubuntu-base:master

===========
