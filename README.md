# move
Copy files across hosts
### Overview
This script could copy file accross hosts, in the script we pre-defined the host name, host IP, user name and path directory parameters so that you don't need to remember and type the parameters when you run the command, it's convenient for you to transfer files between hosts.
### Prerequisites
You need to put the host default parameters in to the script, here is an example:

In this example, you could use the argument "-f/-t s10" to set the remote host to s10, the session will log on by user "root" and the default directory will be "/root/*/".

```sh
elif  [[ $remoteHost == "s10" ]]
then
    remoteIp="9.12.*.*"
    remoteDir="/root/*/"
    remoteUserID="root"
```
### Options
The user should specify the following input parameters for the scripts, use -h for details information for each script command

```
-f, --from <remote host>      copy file from remote host
-t, --to <remote host>        copy file to remote host
-o, --object <file name>      transfered file name
-h, --help                    show this help
```
### Quickstart
The following example command copy the file move.sh from local (the move.ini file located the same directory with the script) to the s10 host default directory:
```sh
$ ./move.sh -t s10 -o move.ini
```
Possible output when running the command:
```sh
localhost >>-->>-->> move.sh >>-->>-->> s10
root@9.12.23.17's password: 
move.sh                                            100% 3061     9.6KB/s   00:00    
Completed....
```
The following example command copy the file move.sh.s10 from remote s10 directory to local:
```sh
$ ./move.sh -f s10 -o move.ini.s10
```
Possible output when running the command:
```sh
localhost <<--<<--<< move.ini.s10 <<--<<--<< s10
root@9.12.23.17's password: 
move.ini.s10                                       100%   38     0.2KB/s   00:00    
Completed....
```
