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
npx playwright test --trace on >> cron.log
 
# grab some radio from nova rock
echo "fetching radio mp3" >> cron.log
wget http://93.190.137.196:8427/ -O /tmp/wa/nlradio.mp3 & 
nlpid=$!

# sleep for a little to get some radio content
sleep 420
kill $nlpid

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

whereis git >> cron.log
git status >> cron.log

git add *.png *.mp3 *.gif
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all >> cron.log

date >> cron.log
echo "Finish with deploy.sh" >> cron.log

