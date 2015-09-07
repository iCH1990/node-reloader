#!/bin/sh

path=`pwd`

if [ `echo $path | awk -F '/' '{print $NF}'` = 'bin' ]
then
    cd ..

    path=`pwd`
fi

fileList=(
'module'
'routes'
)

function inList()
{
    completePath=$1$2

    for fileName in ${fileList[@]}
    do
        filePath=$path/$fileName

        if [ -d $filePath ]
        then
            file=`echo $completePath | awk -F "$filePath/" '{print $2}'`

            if [ "$completePath" = "$filePath/$file" ]
            then
                return 0
            fi
        else
            if [ "$completePath" = "$filePath" ]
            then
                return 0
            fi
        fi
    done

    return -1
}

inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write $path |
while read date time dir file
do
    echo $date $time $dir $file

    for fileName in $fileList
    do
        inList $dir $file

        if [ $? = 0 ]
        then
            npm restart
        fi
    done
done
