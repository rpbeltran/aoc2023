#!/bin/bash

# Usage: ./part1.sh input.txt

max() { 
    local max_find=0 source=$line regex="([0-9]+) $1"
    while [[ $source =~ $regex ]]; do
        max_find=$(($max_find > ${BASH_REMATCH[1]} ? $max_find : ${BASH_REMATCH[1]}))
        source=${source#*"${BASH_REMATCH[1]} $1"}
    done
    echo $max_find
}

sum=0
game=1
while IFS=" " read -r line
do
    if [ $(max "red") -le "12" ] && [ $(max "green") -le "13" ] && [ $(max "blue") -le "14" ]; then
        ((sum+="$game"))
    fi

    ((game+=1))
done < "$1"

echo $sum