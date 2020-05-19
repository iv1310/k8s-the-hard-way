#!/bin/bash

echo -e "\e[32mCreating worker machine.......\e[0m"
for i in 1 2 3; do
  gcloud compute instances create worker-0${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.2${i} \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller \
    --zone asia-southeast1-a
done
