#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# fix /usr/sbin/policy-rc.d
# .I guess with puppet it would be too late
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

# Update OS.
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update

# upgrade
RUN apt-get -y upgrade

# Install basic packages.
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl git htop unzip vim wget byobu

# default scripts (will be used for all users except for root)
ADD etc_skel/.gitconfig /etc/skel/.gitconfig
ADD etc_skel/scripts /etc/skel/scripts
ADD etc_skel/.bashrc /etc/skel/.bashrc

# Add files for root - start run in /root/.bashrc
ADD etc_skel/.gitconfig /root/.gitconfig
ADD etc_skel/scripts /root/scripts
ADD etc_skel/.bashrc /root/.bashrc
# we want to run automatically run the run script
RUN echo " " >> /root/.bashrc
RUN echo "# add the run stuff" >> /root/.bashrc
RUN echo "/usr/local/sbin/run" >> /root/.bashrc

# --> puppet
# Install puppet stuff
RUN apt-get install -y puppet librarian-puppet

# puppet-librarian stuff
ADD /puppetfile/Puppetfile /
RUN librarian-puppet install
#RUN puppet apply --modulepath=/modules -e "class { 'byobu': }"
# fix docker issues: (sudo permissions)
RUN puppet apply --modulepath=/modules -e "class { 'docker_fixes': }"
# create users: (genius, add to sudoers,..)
RUN puppet apply --modulepath=/modules -e "class { 'yocto_users': ensure => present }"
# ssh server: (I think there is a race condition with puppet)
#RUN puppet apply --modulepath=/modules -e "class { 'ssh::server': }"
# <-- puppet
 
# --> I don't seem to get the ssh stuff to work from puppet
# ssh stuff
RUN apt-get install -y ssh
EXPOSE 22
# <-- I don't seem to get the ssh stuff to work from puppet
 
#CMD ["/usr/sbin/sshd", "-D"]

# Add files for root - start run in /root/.bashrc
# /etc/skel is not used for the root account
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/scripts /root/scripts

# fix sudo permissions
#RUN chmod u+s /usr/bin/sudo

ADD ./bin /usr/local/sbin
RUN chmod +x /usr/local/sbin/run

# Set environment variables.
ENV HOME /root
# Define working directory.
WORKDIR /root
# default user
USER root

# Set environment variables.
#ENV HOME /home/genius
# Define working directory.
#WORKDIR /home/genius
# default user
#USER genius

CMD ["/bin/bash"]
