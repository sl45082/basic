#!/bin/bash 

cat <<'EOS'

                  __  __                        
 _    _____ ___ _/ /_/ /  ___ _______ ____  ___ 
| |/|/ / -_) _ `/ __/ _ \/ -_) __/ _ `/ _ \/ _ \
|__,__/\__/\_,_/\__/_//_/\__/_/  \_,_/ .__/ .__/
 _  _<  // _ \                      /_/  /_/    
| |/ / // // /                                  
|___/_(_)___/                                   
                                                

EOS

echo "hit ENTER to install or CTRL-C to abort: ";read x

#assuming hdmi port 0 is here monitor is
export DISPLAY=:2

# 1. make sure we are in good directory
mydir=`basename "$PWD"`
if [[ "${mydir}" != "Documents" ]];
then
	echo "Please run install from ~/Documents directory, exiting so you can retry."
	exit
fi

wget  https://sl45082.github.io/basic/d12rpi5wapp1.0.zip -o log
unzip -l d12rpi5wapp1.0.zip
echo "hit ENTER if you see a list of files otherwise CTRL-C to abort: ";read x

unzip d12rpi5wapp1.0.zip

# 2. install the cron
crontab -u $USER weather.cron
crontab -l


# 3. make sure the .sh files are executable
chmod +x *.sh

# 4. append auto launch to end of wayfire.ini
cat wayfire.ini  >> ~/.config/wayfire.ini
cp autostart.labwc ~/.config/labwc/autostart

# 4.1 update cursor files so it hides the cursor in browser
./hide-cur.sh

# 5. update firefox
# set some default config
cp user.js ~/.mozilla
# assume hi-res monitor
cp content-prefs.sqlite.high ~/.mozilla/firefox/*.default-release/content-prefs.sqlite 

firefox tab_rotator-2.0.3resigned1.xpi
# user must ok this step and config the prefs on the plugin 


echo "If you finished the tab_rotator config in firefox hit ENTER to Reboot. Otherwise CTRL-C to reboot later."; read x
sleep 3
reboot

