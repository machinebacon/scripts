#! /bin/bash


free -h | awk 'NR==3 { print $3 }'
