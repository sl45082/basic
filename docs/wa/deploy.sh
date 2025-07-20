

IMAGEDIR=/tmp/wa
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'

# generate an image for each page during test script


 
# get all the images into the right dir and publish them
cp ${IMAGEDIR}/* .
git add . 
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all
