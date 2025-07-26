cd basic/docs/wa/pw

for i in `ls *.png *.mp3 *.gif`
do
echo "Working on ${i} \n"
#git filter-repo --path ${i} --invert-paths --force
done

#git push --force

