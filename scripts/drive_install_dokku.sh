#!/usr/bin/env bash

scp -oStrictHostKeyChecking=no scripts/install_dokku.sh root@$BASE_DOMAIN:~/install_dokku.sh

ssh -oStrictHostKeyChecking=no root@$BASE_DOMAIN ./install_dokku.sh

echo $BASE_DOMAIN | xclip -selection c

google-chrome http://$BASE_DOMAIN

read

rm -f install.lock

exit
