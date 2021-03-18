#!/bin/bash

if [ $# -ne 1 ]
then
      printf  "\nExample: ./autorecon.sh example.com\n"
else
    export TARGET=$@
    mkdir -p output/$TARGET
    cd output/$TARGET
    subfinder -d $TARGET -o domains.txt | httpx -o webservers.txt -ports 80,8080,8443,8000 -threads 200
    aquatone < webservers.txt
	cat webservers.txt | nuclei -t ~/nuclei-templates/ | tee nuclei.txt
	
fi;
