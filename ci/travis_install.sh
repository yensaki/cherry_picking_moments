#! /bin/bash

__DIR__=$(cd $(dirname $BASH_SOURCE); pwd)

set -ex

if test -z "$PYENV_VERSION"; then
  echo "ERROR: PYENV_VERSION is not provided" >2
  exit 1
fi

if test -n "$LIBPYTHON"; then
  export LIBPYTHON=$(pyenv root)/$LIBPYTHON
fi

if test "$PYENV_VERSION" = "system"; then
  if test -z "$LIBPYTHON"; then
    echo "ERROR: LIBPYTHON is not provided for PYENV_VERSION=system" >2
    exit 1
  fi
  # NOTE: PYENV_VERSION should be the version of LIBPYTHON during install script
  PYENV_VERSION=$(basename $(dirname $(dirname $LIBPYTHON)))
fi
PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -f $PYENV_VERSION

case "$PYENV_VERSION" in
*conda*)
  case "$PYENV_VERSION" in
  *conda2*)
    python_version=2.7
    ;;
  *)
    python_version=3.6
    ;;
  esac
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  conda create -q -n test-environment python=$python_version imagehash
  source $(pyenv prefix)/bin/activate test-environment
  ;;
*)
  pip install --user imagehash
  ;;
esac

bundle install