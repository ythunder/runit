#!/usr/bin/env bash

declare -a proc_name
declare -a proc_command

proc_name=("web")
proc_command=("ls" "ls -l")

function run_command()
{
    for command in ${proc_command[@]}
    do
        exec "$command"
    done
}

function handle_SIG()
{
    res=`jobs -b`
    echo "$res"
}

#trap 'handle_SIG' SIGINT
#trap 'handle_SIG' SIGTERM

run_command
handle_SIG