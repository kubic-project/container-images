#!/bin/bash
  
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]..."

# Fix permission during the build to
# avoid issues at runtime with volumes
chown -R traefik:traefik /var/log
chown -R traefik:traefik /var/lib/traefik
chown -R traefik:traefik /tmp

#======================================
# Imitate upstream image:
# https://hub.docker.com/_/traefik
# same file structure
#--------------------------------------
ln -s /usr/bin/traefik /traefik

#======================================
# authbind byuid doesn't work with
# port range
#--------------------------------------
for value in {1..1023};do
    touch /etc/authbind/byport/$value
    chown traefik /etc/authbind/byport/$value
    chmod 755 /etc/authbind/byport/$value
done

#======================================
# Needed for '--ssl-passthrough'
#--------------------------------------
/usr/sbin/setcap cap_net_bind_service=+ep /usr/bin/traefik
/usr/sbin/setcap -v cap_net_bind_service=+ep /usr/bin/traefik

exit 0
