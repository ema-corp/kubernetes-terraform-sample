#!/bin/bash

set -e

function usage() {
cat <<EOF
Options:
    [--help]                : show usage
    [--debug]               : execute shell with debug mode
    [--target (value)]      : terraform -target=<resource>
    init (value)            : terraform init <sample>
    plan                    : terraform plan
    apply                   : terraform apply
    destroy                 : terraform destroy
    import (value) (value)  : terraform import <to> <from>
EOF
}

# setting defualt value

INIT=false
PLAN=false
APPLY=false
STATE_RM=false
DESTROY=false
IMPORT=false

while [ "$#" -gt 0 ];do
    case "$1" in
        '--help')
            usage
            exit
        ;;
        '--debug')
            set -x
        ;;
        '--target')
            TARGET="--target $2"
            shift
        ;;
        'init')
            INIT=true
            ENV=$2
            shift
        ;;
        'plan')
            PLAN=true
        ;;
        'apply')
            APPLY=true
        ;;
        'destroy')
            DESTROY=true
        ;;
        'import')
            IMPORT=true
            IMPORT_TO="$2"
            IMPORT_FROM="$3"
            shift
            shift
        ;;
        *)
            echo "[ERROR] Invalid command options"
            usage
            exit
        ;;
    esac
    shift
done

function select_workspace() {
    TF_ENV=$(cat .terraform/environment)
    VAR_FILE_OPT="-var-file=tfvars/${TF_ENV?}.tfvars"
    echo "[INFO] terraform workspace select ${TF_ENV?}"
    terraform workspace select ${TF_ENV?}
}

# execute command

if ${INIT}; then
    terraform init
    terraform workspace select ${ENV} || terraform workspace new ${ENV}
fi

if ${PLAN}; then
    select_workspace
    terraform plan ${VAR_FILE_OPT} ${TARGET}
elif ${APPLY}; then
    select_workspace
    terraform apply ${VAR_FILE_OPT} ${TARGET}
elif ${DESTROY}; then
    select_workspace
    terraform destroy ${VAR_FILE_OPT} ${TARGET}
elif ${IMPORT}; then
    select_workspace
    terraform import ${VAR_FILE_OPT} ${IMPORT_TO} ${IMPORT_FROM}
fi
