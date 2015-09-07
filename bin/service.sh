#!/bin/sh

path=`pwd`
logPath="$path/bin/runtime.log"
pidPath="$path/bin/project.pid"

echo "path is $path"
echo "logPath is $logPath"
echo "pidPath is $pidPath"

cd $path/bin

function start()
{
    (
    node www |
    tee -a $logPath |
    while IFS=: read name pid;
    do
        if [ -n "$name" ] && [ -n "$pid" ]
        then
            if [ "$name" = 'pid' ]
            then
                echo "pid is $pid"

                echo $pid > $pidPath

                break
            fi
        fi
    done
    ) &

    if [ -n $1 ] && [ "$1" = "debug" ]
    then
        sh autoReload.sh
    fi
}

function stop()
{
    (
    cat $pidPath |
    while read pid
    do
        echo "stop process $pid"

        kill -2 $pid
    done
    ) &
}

if [ "$1" = 'start' ]
then
    start
elif [ "$1" = 'stop' ]
then
    stop
elif [ "$1" = 'restart' ]
then
    stop

    if [ $? = 0 ]
    then
        start
    fi
fi

cd -
