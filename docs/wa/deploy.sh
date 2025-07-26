#!/bin/bash


PATH=$PATH:/home/admin/.nvm/versions/node/v24.4.1/bin

IMAGEDIR=/tmp/wa
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
mkdir ${IMAGEDIR}
rm -f ${IMAGEDIR}/*.png

# generate an image for each page during test script
cd /home/admin/Documents/basic/docs/wa/pw

echo "Starting with deploy.sh" >> cron.log
date >> cron.log
whereis npx >> cron.log
#npx playwright test --trace on >> cron.log
npx playwright test --reporter=line >> cron.log
 
# get all the images and mp3 into the right dir and publish them
cp ${IMAGEDIR}/* .

# clean up some images
convert captain.png -gravity North -chop 0x170 captain1.png
mv captain1.png captain.png
convert tides.png -crop 980x770+0+150 +repage tides1.png
mv tides1.png tides.png
convert noaa.png -crop 1130x680+0+0 +repage noaa1.png
mv noaa1.png noaa.png
convert accuweather.png -crop 1080x924+100+100 +repage accuweather1.png
mv accuweather1.png accuweather.png

# grab water temp animated gif
cp /home/admin/Documents/surf-temp.gif .

# make a date string to put in images
DATESTR=`date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"`

# grab a chunk of video stream for hatteras, avon, waves-oceanside, rodanthe
# avon pier
wget "https://5b17d0ba29814.streamlock.net:9443/live/avon.stream/chunklist_w1479874796.m3u8" -O /tmp/chunklist_w1479874796.m3u8
URL=`tail -1  /tmp/chunklist_w1479874796.m3u8`
wget "https://5b17d0ba29814.streamlock.net:9443/live/avon.stream/${URL}" -O /tmp/aos.ts
# grab 1st frame and put in a png
ffmpeg -i /tmp/aos.ts -frames:v 1 /tmp/wa/aos.png
convert /tmp/wa/aos.png -gravity Northeast -fill black -pointsize 32 -annotate +20+20 "${DATESTR}" /tmp/wa/aos1.png
# waves-coeanside
wget "https://5b17d0ba29814.streamlock.net:9443/live/rodanthepi.stream/chunklist_w167089497.m3u8" -O /tmp/chunklist_w167089497.m3u8
URL=`tail -1  /tmp/chunklist_w167089497.m3u8`
wget "https://5b17d0ba29814.streamlock.net:9443/live/rodanthepi.stream/${URL}" -O /tmp/wos.ts
# grab 1st frame and put in a png
ffmpeg -i /tmp/wos.ts -frames:v 1 /tmp/wa/wos.png
convert /tmp/wa/wos.png -gravity Northeast -fill black -pointsize 32 -annotate +20+20 "${DATESTR}" /tmp/wa/wos1.png

mv /tmp/wa/wos1.png wos.png
mv /tmp/wa/aos1.png aos.png

# grab some radio from nova rock
echo "fetching radio mp3" >> cron.log
wget http://93.190.137.196:8427/ -O /tmp/wa/nlradio.mp3 & 
nlpid=$!

# sleep for a little to get some radio content
sleep 420
kill $nlpid

whereis git >> cron.log
git status >> cron.log

git add *.png *.mp3 *.gif
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all >> cron.log

date >> cron.log
echo "Finish with deploy.sh" >> cron.log

