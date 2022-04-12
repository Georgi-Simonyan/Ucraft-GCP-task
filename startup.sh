#!/bin/bash
sudo yum install ansible -y
scp -i "C:/Users/Geosimonyan/.ssh/ansible" ./ansible/* ansible@35.246.207.173:/home/ansible/
