#!/usr/bin/env bash
wget https://raw.githubusercontent.com/dokku/dokku/v0.7.2/bootstrap.sh
echo "dokku dokku/vhost_enable boolean true" | debconf-set-selections
echo "dokku dokku/dokku/hostname string dokku.fteychene.xyz" | debconf-set-selections
DOKKU_TAG=v0.7.2 bash bootstrap.sh
dokku plugin:install https://github.com/dokku/dokku-rethinkdb.git rethinkdb
echo "Installation finished"
