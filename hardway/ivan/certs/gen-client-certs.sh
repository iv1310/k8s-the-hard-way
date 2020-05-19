#!/bin/bash

for instance in worker-01 worker-02 worker-03; do
cat > ${instance}-csr.json << EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "Indonesia",
      "L": "Jakarta",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "West Jakarta"
    }
  ]
}
EOF

EXTERNAL_IP=$(gcloud compute instances describe ${instance} --format 'value(networkInterfaces[0].accessConfig[0].natIP)' --zone asia-southeast1-a)
INTERNAL_IP=$(gcloud compute instances describe ${instance} --format 'value(networkInterfaces[0].networkIP)' --zone asia-southeast1-a)

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}

done
