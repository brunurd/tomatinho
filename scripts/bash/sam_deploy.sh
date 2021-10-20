#!/usr/bin/env bash

for f in scripts/bash/functions/*.sh ; do source "$f" ; done

test -z ${1:-} && { echo "Missing the \"stage\" as 1st argument." ; exit 1 ; }

STAGE=$1
LOWER_STAGE=$(python -c "print(\"$STAGE\".lower())")

sam build

sam deploy \
	--stack-name tomatinho-$LOWER_STAGE \
	--s3-bucket tomatinho-deployment-bucket-$LOWER_STAGE \
  --capabilities CAPABILITY_NAMED_IAM \
	--parameter-overrides Stage=$STAGE
