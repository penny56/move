#! /bin/bash

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
    echo "    sem90:    hmcmanager@9.12.16.136"
    echo "    sem257:   hmcmanager@9.12.16.208"
    echo "    rundeck:	yijie@9.12.19.67"
    echo "    s10:      root@9.12.23.17"
    echo "    2lt02     root@9.12.23.102"
    echo "    hmc1:     hmcmanager@9.12.35.134"
    echo "    hmc2:     hmcmanager@9.12.35.135"
    echo "    9kp10:    root@10.20.92.205"
    echo "    2kp10:    root@10.20.92.216"
    echo "    rhel:	root@9.112.234.95"
    echo "    cent:	root@9.111.221.37 <expired>"
    echo
    echo "Examples:"
    echo "    ./move.sh -t s10 -o move.ini    Copy the local move.ini to the remote s10"
    echo "    ./move.sh -f s10 -o move.ini    Copy the file move.ini from s10 to local"
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

if [[ $remoteHost == "sem90" ]]
then
    remoteIp="9.12.16.136"
    remoteDir="/home/hmcmanager/yj/"
    remoteUserID="hmcmanager"
elif [[ $remoteHost == "sem257" ]]
then
    remoteIp="9.12.16.208"
    remoteDir="/home/hmcmanager/yj/"
    remoteUserID="hmcmanager"
elif  [[ $remoteHost == "rundeck" ]]
then
    remoteIp="9.12.19.67"
    remoteDir="/tmp/yj/"
    remoteUserID="yijie"
elif  [[ $remoteHost == "s10" ]]
then
    remoteIp="9.12.23.17"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif  [[ $remoteHost == "2lt02" ]]
then
    remoteIp="9.12.23.102"
    remoteDir="/root/yj/"
    remoteUserID="root"
elif [[ $remoteHost == "hmc1" ]]
then
    remoteIp="9.12.35.134"
    remoteDir="/home/hmcmanager/yj/"
    remoteUserID="hmcmanager"
elif [[ $remoteHost == "hmc2" ]]
then
    remoteIp="9.12.35.135"
    remoteDir="/home/hmcmanager/yj/"
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
