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
ln -s /srv/velum/vendor/bundle/ruby/2.1.0/bin/bundler.ruby2.1 /bin/bundle

exit 0
