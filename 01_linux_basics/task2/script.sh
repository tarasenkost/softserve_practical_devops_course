#!/bin/bash

find ./somefolder -type d -not -path "./somefolder/sharedfolder" -exec chmod +t {} +
chmod g+s ./somefolder/sharedfolder


## What is the difference?
## + collect all the matching directories and pass them as list to the chmod +t command in a single execution
# find ./somefolder -type d -not -path "./somefolder/sharedfolder" -exec chmod +t {} +    

## / syntax tells find to execute the chmod +t command once for each directory (less efficient)
# find ./somefolder -type d -not -path "./somefolder/sharedfolder" -exec chmod +t {} \;
