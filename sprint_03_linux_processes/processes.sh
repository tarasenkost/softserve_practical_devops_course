#!/bin/bash

openssl speed -multi $(grep -ci processor /proc/cpuinfo) #2.78

# sha1sum /dev/zero #1.13

# dd if=/dev/urandom | bzip2 -9 >> /dev/null #0.96

# while :; do :; done  #0.91

# dd if=/dev/zero of=/dev/null  #0.82

# yes > /dev/null  #0.77

# :(){ :|:& };: #don't run!
