#!/bin/bash

# Create a cgroup named "reslimit" and set resource limits
sudo cgcreate -g cpu,memory:reslimit
sudo cgset -r cpu.cfs_quota_us=50000 reslimit
sudo cgset -r memory.limit_in_bytes=500M reslimit

# Run the resource-intensive process using cgexec to associate it with the "reslimit" cgroup
sudo cgexec -g cpu,memory:reslimit /usr/bin/stress --cpu 4 --io 3 --vm 2 --vm-bytes 1G

# Delete the cgroup
sudo cgdelete cpu,memory:reslimit
