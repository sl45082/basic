#!/bin/bash 

#export DESKTOP_SESSION=LXDE-pi-wayfire
export DISPLAY=:2

# let network stack come up
sleep 20

lxterminal & 

sudo /sbin/iw wlan0 set power_save off

# in sudo raspi-config changed settings to support 4k60fs
# in firefox and chromium disabled hardware accleration support

cd ~/Documents

# enable monitor dimming in off hours
./dimmer.sh & 

# generate a cones html for the active hurricane -during the season (july-nov). otherwise show an image
# from weather.com of the US weather. See the script below for more info:
# generate hurricane cones if in season...
./cones.sh & 

# in sudo raspi-config changed settings to support 4k60fs
# in firefox and chromium disabled hardware accleration support

echo "launching firefox...."

##  --kiosk  is unreliable across diff displays so clean any old display resolution config
rm  -f ~/.mozilla/firefox/0iu377v3.default-release-1726962005538/xulstore.json

#firefox  --kiosk   -new-tab https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest \

sleep 10
firefox --display=:0 --kiosk-monitor 0 --kiosk -new-tab https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest \
	-new-tab https://www.surfchex.com/cams/hatteras-web-cam/  \
	-new-tab https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480.htm \
	-new-tab https://www.surfchex.com/cams/avon/ \
	-new-tab https://surfchex.intelliweather.net/imagery/Surfchex/satrad_reg_640x480.htm \
	-new-tab https://www.surfchex.com/cams/rodanthe-web-cam/  \
	-new-tab https://wx.ikitesurf.com/search/35.158/-75.282/8 \
	-new-tab https://www.surfchex.com/cams/waves-nc/ \
	-new-tab https://www.surfchex.com/cams/waves-nc-oceanside/ \
	-new-tab "file:///home/admin/Documents/7day.html" \
	-new-tab "file:///home/admin/Documents/cones.html" \
	-new-tab https://surfcaptain.com/forecast/rodanthe-north-carolina \
	-new-tab https://www.surfchex.com/cams/nags-head-web-cam-abalone-st/ \
	-new-tab "file:///home/admin/Documents/surf-temp.html" \
	-new-tab https://www.accuweather.com/en/us/waves/27982/weather-forecast/2114998  &



exit

#fetch most recent config from cloud to make sure urls are up to date

#sleep for a bit make sure wifi is up
sleep 10
file1="start-ff.bb"
cd ~/Documents
wget https://sl45082.github.io/basic/${file1} -o log

#add error checks to make sure file is valid
flen=`wc -c ${file1} | cut -f1 -d' '`
if [[ $flen -gt 1000 ]]; 
then
	cp $file1 start-ff.sh 
	chmod 775 start-ff.sh
	rm -f $file1
fi
