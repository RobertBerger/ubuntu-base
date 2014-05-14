# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
#FROM phusion/baseimage:0.9.11
FROM phusion/baseimage

# Set correct environment variables.
ENV HOME /root

# ...put your own build instructions here...
# fix /usr/sbin/policy-rc.d
# .I guess with puppet it would be too late
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# --> rber

# ...put your own build instructions here...
# fix /usr/sbin/policy-rc.d
# .I guess with puppet it would be too late
#RUN echo exit 0 > /usr/sbin/policy-rc.d
#RUN chmod +x /usr/sbin/policy-rc.d

# Update OS.
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update

# upgrade
RUN apt-get -y upgrade

# Install basic packages.
RUN apt-get install -y software-properties-common

# fix /usr/sbin/policy-rc.d again
# .I guess with puppet it would be too late
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

# more basic images
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
#RUN echo " " >> /root/.bashrc
#RUN echo "# add the run stuff" >> /root/.bashrc
#RUN echo "/usr/local/sbin/run" >> /root/.bashrc

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

# we need the /dev/net/tun interface for qemu
RUN HERE=$(pwd)&&cd /dev&&MAKEDEV tun&&cd ${HERE}
# <-- rber

# Clean up APT when done.
# .not really we want to add more stuff based on this
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
