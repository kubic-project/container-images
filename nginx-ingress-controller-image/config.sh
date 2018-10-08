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

#======================================
# Complete authbind setup
#--------------------------------------
chown nginx /etc/authbind/byport/80
chmod 755 /etc/authbind/byport/80
chown nginx /etc/authbind/byport/443
chmod 755 /etc/authbind/byport/443
chown nginx /etc/authbind/byuid/496
chmod 755 /etc/authbind/byuid/496

#======================================
# Ensure rootless image works. Files and
# directories must be owned by the
# nginx user
#--------------------------------------
chown -R nginx:nginx /etc/nginx

chown -R nginx:nginx /ingress-controller
chown -R nginx:nginx /etc/ingress-controller

# Required to allow rootless nginx process to write PID file
touch /run/nginx.pid
chown nginx:nginx /run/nginx.pid

# Required by helm chart, the location of the nginx-ingress-controller
# is hard-coded and follows what the upstream image does.
ln -s /usr/bin/nginx-ingress-controller /

exit 0
