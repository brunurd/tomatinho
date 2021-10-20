#!/usr/bin/env bash

tf_plan() {
    dir=$1
    stage=$2

    test -z ${dir:-} && { echo -e "Missing required 1st parameter \"dir\"" ; exit 1 ; }
    test -z ${stage:-} && { echo -e "Missing required 2nd parameter \"stage\"" ; exit 1 ; }

    tf_path="$(pwd)/src/terraform/${dir}"
    vars_path="$(pwd)/cnf/env/${stage}/${dir}/vars.tfvars"
    s3_conf_path="$(pwd)/cnf/env/${stage}/${dir}/s3-conf.tfvars"

    test -f $s3_conf_path || {
        terraform -chdir=$tf_path init
    }

    test -f $s3_conf_path && {
        terraform -chdir=$tf_path init -backend-config=$s3_conf_path
    }

    test -f $vars_path || {
        terraform -chdir=$tf_path plan
    }

    test -f $vars_path && {
        terraform -chdir=$tf_path plan -var-file=$vars_path
    } 
}
