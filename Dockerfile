# Folding@home
#
# VERSION               0.1
# Run with: docker run -d -t -i jordan0day/folding-at-home
# Inspired by magglass1/docker-folding-at-home

# Set environment variables USERNAME, TEAM, PASSKEY, and POWER to customize your Folding client.

FROM ubuntu:14.04

# Install Folding@home
RUN apt-get install -y curl &&\
    curl -O https://fah.stanford.edu/file-releases/public/release/fahclient/debian-testing-64bit/v7.4/fahclient_7.4.4_amd64.deb &&\
    echo '59fe05ffae6f075b354ef3a4284a16d3dfcb4aad89bfbb7b935f28e40ba06276  fahclient_7.4.4_amd64.deb' | sha256sum -c &&\
    dpkg -i --force-depends fahclient_7.4.4_amd64.deb
ADD config.xml /etc/fahclient/
RUN chown fahclient:root /etc/fahclient/config.xml

CMD sed -i -e "s/{{USERNAME}}/$USERNAME/;s/{{TEAM}}/$TEAM/;s/{{POWER}}/$POWER/;s/{{PASSKEY}}/$PASSKEY/" /etc/fahclient/config.xml &&\
    /etc/init.d/FAHClient start &&\
    tail -F /var/lib/fahclient/log.txt
