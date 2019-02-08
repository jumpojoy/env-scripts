#!/bin/sh
ROOT=$(dirname $(readlink -f $0))
VENV_DIR=${ROOT}/.venv
# get args
ACTION="$1"
TEMPLATE="$2"
STACK="$4"

function setup_virtual_env {
  if [ ! -d $VENV_DIR ]; then
    virtualenv $VENV_DIR
  fi
  source $VENV_DIR/bin/activate
  pip install python-openstackclient python-heatclient
  deactivate
}

function cleanup_virtual_env {
  rm -rf $VENV_DIR
}

# decide on action
case "$ACTION" in
"setup")
    setup_virtual_env
    ;;
"cleanup")
    cleanup_virtual_env
    ;;
*)
    echo "Action \"$ACTION\" is now known. Aborting!"
    ;;
esac
