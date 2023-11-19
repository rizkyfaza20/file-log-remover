#!/bin/zsh

prev_count=0
fpath=/var/log/system.log.*.gz
find $fpath -type f -mtime +7  -exec ls -ltrd {} \; > /tmp/file.out
find $fpath -type f -mtime +7  -exec rm -rf {} \;
count=$(cat /tmp/file.out | wc -l)
if [ "$prev_count" -lt "$count" ] ; then
MESSAGE="/tmp/file1.out"
TO="user@mail.com"
echo "Systems log files are deleted older than 7 days"  >> $MESSAGE
echo "+--------------------------------------------- +" >> $MESSAGE
echo "" >> $MESSAGE
cat /tmp/file.out | awk '{print $6,$7,$9}' >> $MESSAGE
echo "" >> $MESSAGE
SUBJECT="WARNING: System log folders are deleted older than 7 days $(date)"
mail -s "$SUBJECT" "$TO" < $MESSAGE
rm $MESSAGE /tmp/file.out
fi
