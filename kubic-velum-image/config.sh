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
# Factory uses ruby2.5 while SLE12 is still on ruby 2.1
if [ -e /srv/velum/vendor/bundle/ruby/2.5.0/bin/bundler.ruby2.5 ]; then
  ln -s /srv/velum/vendor/bundle/ruby/2.5.0/bin/bundler.ruby2.5 /bin/bundle
else
  ln -s /srv/velum/vendor/bundle/ruby/2.1.0/bin/bundler.ruby2.1 /bin/bundle
fi

exit 0
