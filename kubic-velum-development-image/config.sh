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
# Create bundle symlink
#--------------------------------------
ln -s $(find /var/lib/velum/vendor/bundle/ruby -type f -executable -name "bundler.*") /bin/bundle
ln -s $(ls -d /var/lib/velum/vendor/bundle/ruby/*) /srv/velum/vendor/bundle/ruby/current

exit 0
