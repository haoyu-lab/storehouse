
name=""
for item in $(ls)
do
fileName=$item
#echo $fileName
if [  "${fileName##*.}" = jar ]
then
 #   echo $fileName"是jar"
    name=$fileNmae
    break
fi

done

ps -ef | grep $fileName | grep -v grep | awk '{print $2}' | xargs kill -9;

