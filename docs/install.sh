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
if [[ "${mydir}" -ne "Documents" ]];
then
	echo "Please run install from ~/Documents directory, existing so you can retry."
	exit
fi

wget  https://sl45082.github.io/basic/d12rpi5wapp1.0.zip -o log
unzip -l d12rpi5wapp1.0.zip
echo "hit ENTER if you see a list of files otherwise CTRL-C to abort: ";read x

unzip -v d12rpi5wapp1.0.zip

# 2. install the cron
sudo cp -v weather.cron /var/spool/cron/crontabs/admin


# 3. make sure the .sh files are executable
chmod +x *.sh

# 4. append auto launch to end of wayfire.ini
cat wayfire.ini  >> ~/.config/wayfire.ini

sleep 3
echo "Rebooting now...."
reboot

