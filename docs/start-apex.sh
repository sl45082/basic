#!/bin/bash 

# version 1.6 
# github based config
#	file length checks
#	cones integration started
#	cones generation to 1st step
#	delay firefox startup

#export DESKTOP_SESSION=LXDE-pi-wayfire
export DISPLAY=:2

# in sudo raspi-config changed settings to support 4k60fs
# in firefox and chromium disabled hardware accleration support

echo "launching firefox...."

##  --kiosk  is unreliable across diff displays so clean any old display resolution config
rm  -f ~/.mozilla/firefox/hvcfi1v2.default-release/xulstore.json
## firefox  --kiosk   -new-tab https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest \
## firefox  --start-maximized   -new-tab https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest \

sleep 20
firefox  --kiosk   -new-tab https://www.tide-forecast.com/locations/Wrightsville-Beach-North-Carolina/tides/latest \
	-new-tab https://www.surfchex.com/cams/wrightsville-beach/ \
	-new-tab https://www.accuweather.com/en/us/wilmington/28401/weather-forecast/329819?city=wilmington \
	-new-tab https://www.surfchex.com/cams/johnnie-mercers-pier/ \
	-new-tab https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480.htm \
	-new-tab https://wx.ikitesurf.com/search/34.331/-77.336/8 \
	-new-tab https://www.accuweather.com/en/us/apex/27502/weather-forecast/334857 \
	-new-tab https://surfcaptain.com/forecast/wrightsville-beach-north-carolina & 

#start a terminal for debugging if necessary
lxterminal & 

