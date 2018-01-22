#!/usr/bin/env bash

declare -a env_array
declare -a proc_name
declare -a proc_command
declare -a proc_color

proc_name=("web")
proc_command=("ls -ls")
proc_color=("\033[31m" "\E[32m" "\E[34m" "\E[35m" "\E[37m")

RUNIT_VERSION="1.0"

# ERROR
ERROR=13
NOTEXIST_ENV=4000
NOTEXIST_PROC=4001



PROC_FILE="Procfile"
ENV_FILE=".env"
DEFAULT_PORT="8080"
DATE_FORMAT='+%Y-%m-%d|%H:%M:%S'


function usage()
{
    echo "Usage: runit [-c] [-f procfile|Procfile] [-e envfile|.env]"
    echo "Runit Version: $RUNIT_VERSION"
}

# $1:name + command对应的下标  $2:进程id
function log()
{
    date=`date +%H:%M:%S`

    index="$1"
    name="${proc_name["$index"]}"
    command="${proc_command["$index"]}"
    pid="$2"
    str="$date"" ""$name"" | ""$command"" started with pid ""$2"
    echo -e `echo "${proc_color[$index]}""$str""\033[0m"`
}

# z:the value is empty
# n:string isnot empty
function verify()
{
    until [ -z "$1" ]
    do
        case "$1" in
            # 检测procfile文件
            "-c")
                echo "check profile"
            ;;

            # 寻求帮助
            "-h")
                echo "help it"
            ;;

            # 环境变量提示参数
            "-e")
                echo "this is env"
                shift
                if [ -n "$1" ]
                then
                    ENV_FILE="$1"
                    get_env
                else
                    usage
                    exit "$NOTEXIST_ENV"
                fi
            ;;

            # procfile提示参数
            "-f")
                echo "this is procfile"
                shift
                if [ -n "$1" ]
                then
                    PROCFILE="$1"
                    get_procfile
                else
                    usage
                    exit "$NOTEXIST_PROC"
                fi
            ;;
            * )
                echo "fault"
            ;;
        esac
        shift
    done
}

log 0 255