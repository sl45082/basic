

IMAGEDIR=~/Documents/surftemp
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
#
# get all the images into the right dir
cp ${IMAGEDIR}/* .
git add . 
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all
