FROM       adgico/cyber-dojo-no-docker
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Add the www-data user to the docker group
# so the server can run docker containers
RUN usermod -aG docker www-data

RUN /var/www/cyber-dojo/exercises/cache.rb
RUN /var/www/cyber-dojo/languages/cache.rb

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]


