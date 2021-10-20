#!/usr/bin/env bash

for f in scripts/bash/functions/*.sh ; do source "$f" ; done

test -z ${1:-} && { echo "Missing the \"stage\" as 1st argument." ; exit 1 ; }

STAGE=$1

tf_apply "1-bootstrap" "global"
tf_apply "2-deployment-bucket" "$STAGE"
