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

# Install sudo
RUN apt-get install -y sudo

# upgrade
RUN apt-get -y upgrade

# fix sudo permissions - just in case
RUN chmod u+s /usr/bin/sudo

# Install basic packages.
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl git htop unzip vim wget

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

RUN chown -R student:student /home/student
 
# ssh stuff
RUN apt-get install -y ssh
RUN mkdir /var/run/sshd
RUN /etc/init.d/ssh start

EXPOSE 22
 
#CMD ["/usr/sbin/sshd", "-D"]

# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/scripts /root/scripts

# fix sudo permissions
RUN chmod u+s /usr/bin/sudo

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# default user
USER root

ADD root/readme /root/run.sh
RUN chmod +x /root/run.sh
RUN /root/run.sh
