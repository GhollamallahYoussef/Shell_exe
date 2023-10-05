operator=$2
resultPlus=$(( $1+$3 ))

if [ $operator == "+" ]
then
echo " $1 $operator $3 = $(( $resultPlus ))"
fi

resultMultiply=$(( $1*$3 ))
if [ $operator == 'x' ]
then
echo " $1 $operator $3 = $(( $resultMultiply ))"
fi

resultMoins=$(( $1-$3 ))
if [ $operator == "-" ]
then
echo " $1 $operator $3 = $(( $resultMoins ))"
fi
