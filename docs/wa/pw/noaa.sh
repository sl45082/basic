#!/bin/bash

# try and get latest radar image from noaa

# 1st get the url of the image
NOAA_IMG=`wget -q -O - "https://www.star.nesdis.noaa.gov/goes/sector_band.php?sat=G19&sector=eus&band=11&length=71&dim=1%20&" | grep -i "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR/eus/11/" | tail -1 | cut -f1 -d ',' |tr -d "'" |xargs`

echo "Fetching the image: ${NOAA_IMG}"

# 2nd get the actual image
wget "$NOAA_IMG" -O /tmp/wa/noaa1.jpg
convert /tmp/wa/noaa1.jpg /tmp/wa/noaa.png

