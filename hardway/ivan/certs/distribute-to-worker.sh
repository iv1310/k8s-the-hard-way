#!/bin/bash

for instance in worker-01 worker-02 worker-03; do  
  echo -e "\e[32mSending certs and private-key to ${instance}...........\e[0m"
  gcloud compute scp ca.pem ${instance}-key.pem ${instance}.pem ${instance}:~/
done
