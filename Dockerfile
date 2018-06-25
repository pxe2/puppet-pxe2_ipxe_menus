FROM puppet/puppet-agent-alpine:latest
LABEL maintainer="peter@pouliot.net"
COPY Dockerfile /Dockerfile
ADD VERSION .
VOLUME ./pxe2 /pxe2
RUN mkdir -p /etc/puppetlabs/code/modules/pxe2_ipxe_menus
COPY . /etc/puppetlabs/code/modules/pxe2_ipxe_menus

COPY Puppetfile /etc/puppetlabs/code/environments/production/Puppetfile
COPY files/hiera /etc/puppetlabs/code/environments/production/data
COPY files/hiera/hiera.yaml /etc/puppetlabs/code/environments/production/hiera.yaml
COPY files/hiera/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
RUN \
    apk update \
    && apk add --no-cache --virtual ntp git gawk sed grep \
    && ntpd -d -q -n -p 0.pool.ntp.org \
    && gem install r10k \
    && cd /etc/puppetlabs/code/environments/production/ \
    && r10k puppetfile install --verbose DEBUG2 \
    && ln -s data/hiera.yaml /etc/puppetlabs/hiera.yaml \
    && cp data/nodes/pxe2-ipxe-menus.yaml data/nodes/`facter | grep fqdn | awk '{print $3}'| sed -e 's/\"//g'| awk -F. '{print $1}'`.yaml \
    && ls data/nodes && echo $HOSTNAME \
    && puppet module list \
    && puppet module list --tree
#RUN \
ENTRYPOINT \
#   puppet apply --debug --trace --verbose --modulepath=/etc/puppetlabs/code/modules:/etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/modules/pxe2_ipxe_menus/examples/init.pp
    puppet apply --debug --trace --verbose --modulepath=/etc/puppetlabs/code/modules:/etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/modules/pxe2_ipxe_menus/examples/all.pp

#ENTRYPOINT /bin/ash
WORKDIR /pxe2
