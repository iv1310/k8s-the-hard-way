#!/bin/bash

set -e

ansible-playbook -i terraform.py \
	playbook.yml "$@"
