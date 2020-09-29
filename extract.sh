args=("$@")

FILE_NAME=${args[0]}
INTERVAL=${args[1]}
TOTAL_TIME=$(ffmpeg -i $FILE_NAME 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,// | sed 's@\..*@@g' | awk '{ split($1, A, ":"); split(A[3], B, "."); print 3600*A[1] + 60*A[2] + B[1] }')
FILE_NAME_WITHOUT_EXT=$(echo "$FILE_NAME" | sed 's/\.[^.]*$//')
echo '$FILE_NAME_WITHOUT_EXT'

START_TIME='00:00:00'
END_TIME='00:00:00'
TIME_IN_SECOND=0
HOUR=00
MINUTE=00
SECOND=00
COUNT=0

if [ ! -d "./snip" ] 
then
    mkdir snip    
fi

while [ $TIME_IN_SECOND -le $TOTAL_TIME ] && [ $(($TOTAL_TIME-$TIME_IN_SECOND)) -ge 5 ]
do
  
	    let TIME_IN_SECOND=TIME_IN_SECOND+INTERVAL
	    let HOUR=$(bc <<< "$TIME_IN_SECOND/3600")
	    let MINUTE=$(bc <<< "$TIME_IN_SECOND/60")
	    let SECOND=$(bc <<< "$TIME_IN_SECOND%60")
	    let COUNT=COUNT+1

	    END_TIME="${HOUR}:${MINUTE}:${SECOND}"
	    ffmpeg -y -loglevel info -i $FILE_NAME -ss $START_TIME -to $END_TIME -r 30 snip/$COUNT'_'$FILE_NAME_WITHOUT_EXT'.mp4'
	    
	    #END_TIME FOR PREVIOUS IS START TIME FOR NEW
	    START_TIME=$END_TIME
done

