#!/usr/bin/env bash

sleep 10

APP_NAME="hello"
ORIGIN_DIR=$(pwd)

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BASE_DIR="$SCRIPTS_DIR/../hello-node-buildpack"

while [ -f "install.lock" ]; do
  sleep 1
done

if [ -d "$BASE_DIR/.git" ]; then
  rm -Rf $BASE_DIR/.git
fi

cd $BASE_DIR
git init
git add .
git commit -m "Initial commit"

echo
echo "> git remote add dokku dokku@$BASE_DOMAIN:$APP_NAME"
git remote add dokku dokku@$BASE_DOMAIN:$APP_NAME

echo
echo "> git push dokku master"
git push dokku master

echo
echo "> #Open http://$APP_NAME.$BASE_DOMAIN"
read
google-chrome http://$APP_NAME.$BASE_DOMAIN

echo
echo "> # Edit something on main page !"
echo "> vim views/pages/index.ejs"
read
vim views/pages/index.ejs

echo "> git add views/pages/index.ejs"
git add views/pages/index.ejs
echo '> git commit -m "Glorious change"'
git commit -m "Glorious change"

echo
echo "> git push dokku master"
read
git push dokku master
