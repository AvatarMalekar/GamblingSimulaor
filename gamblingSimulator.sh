#!/bin/bash
echo "-----------------------------------------------WELLOME TO GAMBLING SIMULATOR-------------------------------------------------"

#CONSTANT
STAKE_FOR_DAY=100;
WINNING_LIMIT_TO_RESIGN_FOR_DAY=150;
LOSING_LIMIT_TO_RESIGN_FOR_DAY=50;
TOTAL_DAYS_OF_MONTH=20;
BET_PER_GAME=1;
WIN=1;
LOSE=0;

#VARIABLE
flag=0
maxWinningAmount=-1;
maxLosingAmmount=-1;
declare -A GamblerDictionary

#FUNCTIONS
function dailyBet(){
	while [ $cashInHand -le $WINNING_LIMIT_TO_RESIGN_FOR_DAY -a $cashInHand -ge $LOSING_LIMIT_TO_RESIGN_FOR_DAY ]
	do
	bet=$((RANDOM%2))
		if [ $bet -eq $WIN ]
		then
			((countForMaxWin++))
			cashInHand=$(($cashInHand+1));
		else
			((countForMaxLose++))
			cashInHand=$(($cashInHand-1));
		fi
	done
}
function winOrLoseDecider(){
	if [ $cashInHand -ge $WINNING_LIMIT_TO_RESIGN_FOR_DAY ]
	then
		GamblerDictionary[WON]=$((${GamblerDictionary[WON]}+1))
	else
		GamblerDictionary[LOSE]=$((${GamblerDictionary[LOSE]}+1))
	fi
}
function luckiestDayDecider(){
	if [ $countForMaxWin -gt $maxWinningAmount -a $cashInHand -ge $WINNING_LIMIT_TO_RESIGN_FOR_DAY ]
	then
		maxWinningAmount=$countForMaxWin
		luckiestDay=$i
	fi
}
function unLuckiestDayDecider(){
	if [ $countForMaxLose -gt $maxLosingAmmount -a $cashInHand -le $LOSING_LIMIT_TO_RESIGN_FOR_DAY ]
   then
      maxLosingAmmount=$countForMaxLose
      UnLuckiestDay=$i
   fi
}
function monthlyWinOrLose(){
	for i in ${!GamblerDictionary[@]}
	do
		GamblerDictionary[$i]=$((${GamblerDictionary[$i]}*50))
	done
}
function showKeyValueOfDictionary(){
	echo ${!GamblerDictionary[@]}
	echo ${GamblerDictionary[@]}
}

function clearDictionary(){
	for i in ${!GamblerDictionary[@]}
	do
   	GamblerDictionary[$i]=0
	done
}
function playInNextMonthOrNot(){
if [ $1 -gt $2 ]
then
   read -p "Do you want to continue for next month..(y/n): " result
   if [ "$result" = "Y" -o "$result" = "y" ]
   then
     local flag=0;
   else
     local flag=1;
   fi
else
  local flag=1
fi
echo $flag
}

#MAIN-FUNCTION
while [ $flag -eq 0 ]
do
	for (( i=1; i<=$TOTAL_DAYS_OF_MONTH; i++ ))
	do
		cashInHand=$STAKE_FOR_DAY
		countForMaxWin=0
		countForMaxLose=0

		#FUNCTION-CALLS
		dailyBet
		winOrLoseDecider
		luckiestDayDecider
		unLuckiestDayDecider
	done

	echo "Total days staticstics:"

	#FUNCTION-CALLS
	showKeyValueOfDictionary
	monthlyWinOrLose

	echo "Total ammount staticstics for a month:"

	#FUNCTION-CALL
	showKeyValueOfDictionary

	echo "Luckiest Day is:" $luckiestDay
	echo "Unluckiest Day is:" $UnLuckiestDay
	echo "Max ammount Won:" $maxWinningAmount
	echo "max ammount Lost:" $maxLosingAmmount 

	#FUNCTION-CALLS
	flag=$(playInNextMonthOrNot ${GamblerDictionary[WON]} ${GamblerDictionary[LOSE]})
	clearDictionary
done
