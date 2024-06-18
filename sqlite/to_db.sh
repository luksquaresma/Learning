#!/bin/bash

# this script takes a local .sql file and generates a t.sqlite db file
path_db=./t.sqlite

fok() {
    p=$1
    if [[ "$p" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        p=true
    else
        p=false
    fi
    $p
}

find_file() {
    {
        echo; read -p "Which file creates the sqlite db? " path_config
    } && {
        if [ ! -f $path_config ]; then
            echo "ERROR - no DB config file found in: $path_config"
            if read -p "Do you retry? (y/N): " && (fok $REPLY); then
                find_file;
            else
                echo "ABORT - No DB config file found!"; exit 1;
            fi
        else 
            echo; echo "OK - DB config file found in: $path_config"
        fi
    }
}

echo "........LOCAL SQLITE DB HELPER........";
{
    if [ -f $path_db ]; then
        echo; echo "INFO - There is already a DB file created as $path_db !"
        if read -p "    Do you wish to erase it? (y/N): " && (fok $REPLY); then
            rm -rf $path_db
            echo "    File $path_db erased!"
        else
            echo; echo "ABORT - No DB config file found!"; exit 1;
        fi
    else
        echo; echo "INFO - No DB file present as $path_db";
    fi
} && {
    find_file
} && {
    sqlite3 $path_db < ./$path_config
} && {
    if [ -f $path_db ]; then
        echo; echo "OK - DB file created as $path_db !"
    else
        echo; echo "ERROR - DB file not present as $path_db!"; exit 1
    fi
}