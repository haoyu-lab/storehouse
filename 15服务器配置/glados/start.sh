name=""
for item in $(ls)
do
fileName=$item
#echo $fileName
if [  "${fileName##*.}" = jar ]
then
    mkdir -p ./logs/gc
    name=$fileNmae
    break
fi

done

nohup java -jar -Xss8m  -Xloggc:./logs/gc/gc-%t.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCCause -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M  -XX:+UseParNewGC -XX:+UseConcMarkSweepGC $fileName   --spring.config.location=config/application.yml & #  --logging.config=config/logback-spring.xml  &
tail -1000f nohup.out
