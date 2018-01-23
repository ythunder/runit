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



declare -a proc_command
proc_command=("ls" "ls -l &" "sleep" "fork &")
NUMBER=4


# 处理command字符串，必须接受全局变量NUMBER，即从PROCFILE中读得的命令数
# 逐个处理，如果有&符号，去掉
function handle_str()
{
    i=0
    while (( $i<4 ))
    do
        temp_str="${proc_command[i]}"
        if [[ "${temp_str:(-1)}" == "&" ]];then
            comm_len=${#temp_str}
            let comm_len--
            proc_command[i]="${temp_str:0:$comm_len}"
        fi
        let i++
    done
}


handle_str
echo ${proc_command[*]}