#!/bin/bash

if [ $# -ne 1 ]
then
      printf  "\nExample: ./autorecon.sh example.com\n"
else
    export TARGET=$@
    mkdir -p output/$TARGET
    cd output/$TARGET
    subfinder -d $TARGET -o domains.txt | httpx -o webservers.txt  | nuclei  -t ~/nuclei-templates/files/ -t ~/nuclei-templates/cves/ -t ~/nuclei-templates/security-misconfiguration/ 
    cat webservers.txt | aquatone
fi;