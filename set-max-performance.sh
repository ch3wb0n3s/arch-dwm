#!/bin/bash
# filepath: /home/siamax/set-max-performance.sh

# Set CPU governor to performance
sudo /usr/bin/cpupower frequency-set -g performance

# (Optional) Set Intel GPU to max frequency (uncomment if you want)
sudo /usr/bin/intel_gpu_frequency -m

# You can add more performance-related commands here