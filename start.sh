#!/bin/bash
WORKSPACE=wokspace
docker run -it --rm \
    -v $(pwd)/vars:/${WORKSPACE}/vars \
    -v $(pwd)/scripts:/${WORKSPACE}/scripts \
    -v $(pwd)/certs:/${WORKSPACE}/certs \
    -w /${WORKSPACE} microsoft/azure-cli 
