#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Update OS.
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install basic packages.
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl git htop unzip vim wget

# Install puppet stuff
RUN apt-get install -y puppet librarian-puppet

# puppet-librarian stuff
ADD /puppetfile/Puppetfile /
RUN librarian-puppet install
RUN puppet apply --modulepath=/modules -e "class { 'adamstrawson/puppet-byobu': }"
RUN puppet apply --modulepath=/modules -e "class { 'torrancew/puppet-account': }"


# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/scripts /root/scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root
