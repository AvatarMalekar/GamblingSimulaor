#!/bin/bash
echo "-----------------------------------------------WELLOME TO GAMBLING SIMULATOR-------------------------------------------------"
STAKE_FOR_DAY=100;
WINNING_LIMIT_TO_RESIGN_FOR_DAY=150;
LOSING_LIMIT_TO_RESIGN_FOR_DAY=50;
BET_PER_GAME=1;
WIN=1;
LOSE=0;

cash_in_hand=$STAKE_FOR_DAY
while [ $cash_in_hand -le $WINNING_LIMIT_TO_RESIGN_FOR_DAY -a $cash_in_hand -ge $LOSING_LIMIT_TO_RESIGN_FOR_DAY ]
do
bet=$((RANDOM%2))
	if [ $bet -eq $WIN ]
	then
		cash_in_hand=$(($cash_in_hand+1));
	else
		cash_in_hand=$(($cash_in_hand-1));
	fi
done
	
if [ $cash_in_hand -ge $WINNING_LIMIT_TO_RESIGN_FOR_DAY ]
then
	echo "Gambler won and resigned...!!"
else
	echo "Gambler lost and resigned...!!"
fi
