#!/bin/bash

echo "`hostname`  `env | grep SLURM_NODEID`"
sleep 10s
