#!/usr/bin/env bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TODO_DIR="$SCRIPTS_DIR/../todo-rethink"

if [ -d "$TODO_DIR/.git" ]; then
  rm -Rf $TODO_DIR/.git
fi

HELLO_DIR="$SCRIPTS_DIR/../hello-node-buildpack"

if [ -d "$HELLO_DIR/.git" ]; then
  rm -Rf $HELLO_DIR/.git
fi

rm serverid
