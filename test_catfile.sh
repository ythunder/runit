#!/usr/bin/env bash

envfile=/Users/lxd/Desktop/runit.git/test/fixtures/env_file_with_comments
procfile=/Users/lxd/Desktop/runit.git/test/fixtures/procfile_with_tabs

string='#*'
declare -a env_array
declare -a proc_name
declare -a proc_command
declare -a proc_color

proc_color=("\E[31m" "\E[32m" "\E[34m" "\E[35m" "\E[37m")

function get_env()
{
    if [ -e "$envfile" ]
    then
        cat "$envfile" | while read line;do
            if [[ -n "$line" ]] && [[ $line != \#* ]]
            then
                eval "$line"
            fi
        done
    fi
}

function get_procfile()
{
    i=0
    if [ -e "$procfile" ]
    then
        cat "$procfile" | while read line;do
            if [[ -n "$line" ]] && [[ $line != \#* ]]
            then
                proc_name[i]=`echo ${line%:*}`
                proc_command[i]=`echo ${line#*:}`
                let i++
            fi
        done
    fi
}

get_procfile