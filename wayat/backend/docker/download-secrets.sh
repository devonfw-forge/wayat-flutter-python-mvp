#!/bin/sh

wget -O firebase.json https://storage.cloud.google.com/wayat_secrets/firebase.json
if [[ $? -ne 0 ]]; then
    echo "Failed to download Firebase Credentials"
    exit 1; 
fi