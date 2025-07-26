#!/bin/bash
watch -c -n 1 'nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total,temperature.gpu,power.draw --format=csv | column -t -s ","'
