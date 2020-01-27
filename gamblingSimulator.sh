#!/bin/bash -x
echo "-----------------------------------------------WELLOME TO GAMBLING SIMULATOR-------------------------------------------------"
STAKE_FOR_DAY=100;
BET_PER_GAME=1;
WIN=1;
LOSE=0;
bet=$((RANDOM%2))
if [ $bet -eq $WIN ]
then
	echo "CONGRANTS..!! YOU WON.."
else
	echo "SORRY..!! YOU LOSE..!! BETTER LUCK NEXT TIME..!!"
fi
