#!/bin/bash
echo "-----------------------------------------------WELLOME TO GAMBLING SIMULATOR-------------------------------------------------"
STAKE_FOR_DAY=100;
WINNING_LIMIT_TO_RESIGN_FOR_DAY=150;
LOSING_LIMIT_TO_RESIGN_FOR_DAY=50;
TOTAL_DAYS_OF_MONTH=20;
BET_PER_GAME=1;
WIN=1;
LOSE=0;
declare -A GamblerDictionary
for (( i=0; i<$TOTAL_DAYS_OF_MONTH; i++ ))
do
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
		GamblerDictionary[WON]=$((${GamblerDictionary[WON]}+1))
	else
		GamblerDictionary[LOSE]=$((${GamblerDictionary[LOSE]}+1))
	fi
done
echo "Total days staticstics:"
echo ${!GamblerDictionary[@]}
echo ${GamblerDictionary[@]}

for i in ${!GamblerDictionary[@]}
do
	GamblerDictionary[$i]=$((${GamblerDictionary[$i]}*50))
done
echo "Total ammount staticstics:"
echo ${!GamblerDictionary[@]}
echo ${GamblerDictionary[@]}
