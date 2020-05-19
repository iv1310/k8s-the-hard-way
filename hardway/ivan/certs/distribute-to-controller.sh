#!/bin/bash

for instance in controller-01 controller-02 controller-03; do  
  echo -e "\e[32mSending certs and private-key to ${instance}...........\e[0m"
  gcloud compute scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem service-account-key.pem service-account.pem ${instance}:~/
done
