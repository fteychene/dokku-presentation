#!/usr/bin/env bash

APP_NAME="todo"
ORIGIN_DIR=$(pwd)

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BASE_DIR="$SCRIPTS_DIR/../todo-rethink"

if [ -d "$BASE_DIR/.git" ]; then
  rm -Rf $BASE_DIR/.git
fi

cd $BASE_DIR
git init
git add .
git commit -m "Initial commit"

echo "> git remote add dokku dokku@$BASE_DOMAIN:$APP_NAME"
git remote add dokku dokku@$BASE_DOMAIN:$APP_NAME

echo
echo "> # Create app on dokku"
echo "> ssh dokku@$BASE_DOMAIN apps:create $APP_NAME"
read
ssh dokku@$BASE_DOMAIN apps:create $APP_NAME
ssh dokku@$BASE_DOMAIN proxy:ports-add $APP_NAME http:80:5000

echo
echo "> # Create rethinkdb database on dokku"
echo "> ssh dokku@$BASE_DOMAIN rethinkdb:create $APP_NAME"
read
ssh dokku@$BASE_DOMAIN rethinkdb:create $APP_NAME

echo
echo "> # link rethinkdb database to app"
echo "> ssh dokku@$BASE_DOMAIN rethinkdb:link $APP_NAME $APP_NAME"
read
ssh dokku@$BASE_DOMAIN rethinkdb:link $APP_NAME $APP_NAME

echo
echo "> git push dokku master"
read
git push dokku master

echo "> #Open http://$APP_NAME.$BASE_DOMAIN"
google-chrome http://$APP_NAME.$BASE_DOMAIN
