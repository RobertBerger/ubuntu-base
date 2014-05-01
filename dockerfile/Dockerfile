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
RUN apt-get install -y openssh-server sudo

# Install puppet stuff
RUN apt-get install -y puppet librarian-puppet

# puppet-librarian stuff
ADD /puppetfile/Puppetfile /
RUN librarian-puppet install
RUN puppet apply --modulepath=/modules -e "class { 'byobu': }"
#RUN puppet apply --modulepath=/modules -e "class { 'account': }"

# create student
RUN mkdir -p /home/student
 
RUN useradd student
RUN echo "student:student" | chpasswd
 
RUN mkdir -p /home/student/.ssh; chown student /home/student/.ssh; chmod 700 /home/student/.ssh
#ADD ./authorized_keys /home/student/.ssh/
#ADD ./authorized_keys /student/.ssh/
 
RUN echo "student ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
 
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
 
EXPOSE 22
 
#CMD ["/usr/sbin/sshd", "-D"]

# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/scripts /root/scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root
