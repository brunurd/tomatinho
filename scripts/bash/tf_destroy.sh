#!/usr/bin/env bash

for f in scripts/bash/functions/*.sh ; do source "$f" ; done

test -z ${1:-} && { echo "Missing the \"stage\" as 1st argument." ; exit 1 ; }

STAGE=$1

tf_destroy "2-deployment-bucket" "$STAGE"
