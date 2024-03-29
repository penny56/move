#! /bin/bash

# Updated on Jun. 28, 2023 --- Add home directory for dpmsoltest account
# Updated on Jan. 12, 2022 --- Update the zp93l7 server hostname from rundeck to 93l7
# Updated on Aug. 02, 2021 --- Update the rundeck ssh account from root to mayijie cause root not directly log on 93l7 server
# Updated on Jan. 20, 2020 --- Update the hostname s10 to rundeck, rundeck to runnode
# Updated on Dec. 19, 2018 --- Update the print information
# Updated on Dec. 19, 2018 --- Update the indent and 9kp10 host issue

# parameters for local host
localDir=`pwd`/

function  usage() {
    echo
    echo "Copy the file from/to remote host"
    echo "Usage: $0 [options] [parameters]"
    echo
    echo "-f, --from <remote host>      copy file from remote host"
    echo "-t, --to <remote host>        copy file to remote host"
    echo "-o, --object <file name>      transfered file name"
    echo "-h, --help                    show this help"
    echo
    echo "Now the support remote host list include:"
    echo "    sea90:    hmcmanager@9.12.16.136"
    echo "    sem257:   hmcmanager@9.12.16.208"
    echo "    runnode:	yijie@9.12.19.67"
    echo "    93l7:     mayijie@9.12.23.17"
    echo "    2lt02     root@9.12.23.102"
    echo "    hmc1:     hmcmanager@9.12.35.134"
    echo "    hmc2:     hmcmanager@9.12.35.135"
    echo "    9kp10:    root@10.20.92.205"
    echo "    2kp10:    root@10.20.92.216"
    echo "    rhel:	root@9.112.234.95"
    echo "    cent:	root@9.111.221.37 <expired>"
    echo "    liw:	root@9.110.179.218"
    echo "    dave:  root@9.12.23.251"
    echo
    echo "Examples:"
    echo "    ./move.sh -t 93l7 -o move.ini    Copy the local move.ini to the remote 93l7"
    echo "    ./move.sh -f 93l7 -o move.ini    Copy the file move.ini from 93l7 to local"
    echo
}

while [[ $# > 0 ]]
do
    key="$1"
    shift
    case $key in
        -f|--from|-t|--to)
            direction="$key"
            remoteHost="$1"
            shift
        ;;
        -r|--remote)
            $remoteIp="$1"
            shift
        ;;
        -o|--object)
            fileName="$1"
            shift
        ;;
        -h|--help)
            usage
            exit 0
        ;;
        *)
            echo "invalid option(s): $key $*"
            usage
            exit 2
        ;;
    esac
done

if [[ $remoteHost == "sea90" ]]
then
    remoteIp="9.12.16.136"
    remoteDir="/tmp/yj/"
    remoteUserID="hmcmanager"
elif [[ $remoteHost == "sem257" ]]
then
    remoteIp="9.12.16.208"
    remoteDir="/tmp/yj/"
    remoteUserID="hmcmanager"
elif  [[ $remoteHost == "runnode" ]]
then
    remoteIp="9.12.19.67"
    remoteDir="/tmp/yj/"
    remoteUserID="yijie"
elif  [[ $remoteHost == "93l7" ]]
then
    remoteIp="9.12.23.17"
    remoteDir="/home/mayijie/"
    remoteUserID="mayijie"
elif  [[ $remoteHost == "l7" ]]
then
    remoteIp="9.12.23.17"
    remoteDir="/home/dpmsoltest/"
    remoteUserID="dpmsoltest"
elif  [[ $remoteHost == "2lt02" ]]
then
    remoteIp="9.12.23.102"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "hmc1" ]]
then
    remoteIp="9.12.35.134"
    remoteDir="/tmp/yj/"
    remoteUserID="hmcmanager"
elif [[ $remoteHost == "hmc2" ]]
then
    remoteIp="9.12.35.135"
    remoteDir="/tmp/yj/"
    remoteUserID="hmcmanager"
elif [[ $remoteHost == "rhel" ]]
then
    remoteIp="9.112.234.95"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "cent" ]]
then
    remoteIp="9.111.221.37"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "9kp10" ]]
then
    remoteIp="10.20.92.205"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "2kp10" ]]
then
    remoteIp="10.20.92.216"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "liw" ]]
then
    remoteIp="9.110.179.218"
    remoteDir="/tmp/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "dave" ]]
then
    remoteIp="9.12.23.251"
    remoteDir="/root/"
    remoteUserID="root"
else
    echo "Please add the remote host parameters to the script..."
    exit 2
fi

if [[ $direction == "-f" || $direction == "--from" ]]
then
    echo "localhost <<--<<--<< $fileName <<--<<--<< $remoteHost"
    scp $remoteUserID@$remoteIp:$remoteDir$fileName $localDir
fi

if [[ $direction == "-t" || $direction == "--to" ]]
then
    echo "localhost >>-->>-->> $fileName >>-->>-->> $remoteHost"
    scp $localDir$fileName $remoteUserID@$remoteIp:$remoteDir
fi

echo "Completed...."
