#/bin/bash

who | awk '{print $1,$3,$4,$5}'
