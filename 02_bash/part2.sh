#!/bin/bash

# Usage: ./part2.sh input.txt

max() { 
    local max_find=0 source=$line regex="([0-9]+) $1"
    while [[ $source =~ $regex ]]; do
        max_find=$(($max_find > ${BASH_REMATCH[1]} ? $max_find : ${BASH_REMATCH[1]}))
        source=${source#*"${BASH_REMATCH[1]} $1"}
    done
    echo $max_find
}

sum=0
while IFS=" " read -r line
do    
    ((sum+=$(max "red") * $(max "green") * $(max "blue")))
done < "$1"

echo $sum