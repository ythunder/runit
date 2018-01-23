#!/usr/bin/env bash

declare -a proc_name
declare -a proc_command

CHILD_SHELL=""

proc_name=("web")
proc_command=("ls" "ls -l")

function run_command()
{
    for command in ${proc_command[@]}
    do
        exec "$command"
    done
}


LS="ls"
SLEEP="sleep 10"
SLEEP1="sleep 5"
function test()
{
    exec $LS &
    exec $SLEEP &

}

function handle_SIG()
{
    CHILD_SHELL=`jobs -p`
    for date in ${CHILD_SHELL[@]};do
        kill $date
        done
}

trap 'handle_SIG' SIGINT
#trap 'handle_SIG' SIGTERM

test
wait