#! /bin/bash

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
    echo "    s10:      root@9.12.23.17"
    echo "    hmc1:     hmcmanager@9.12.35.134"
    echo "    hmc2:     hmcmanager@9.12.35.135"
    echo "    9kp10:    root@10.20.92.205"
    echo "    2kp10:    root@10.20.92.216"
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
elif  [[ $remoteHost == "s10" ]]
then
    remoteIp="9.12.23.17"
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
elif [[ $remoteHost == "9kp10" ]]
    then
        remoteIp="root@10.20.92.205"
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
    echo "copy from the remote host..."
    scp $remoteUserID@$remoteIp:$remoteDir$fileName $localDir
fi

if [[ $direction == "-t" || $direction == "--to" ]]
then
    echo "copy to the remote host..."
    scp $localDir$fileName $remoteUserID@$remoteIp:$remoteDir
fi

echo "Completed...."
