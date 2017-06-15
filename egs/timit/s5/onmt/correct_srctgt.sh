#!/bin/bash

infile=$1 #feature
infile2=$2 #target

grep -nr "\[" $infile | sed 's/:.*//g' > $infile.l1
grep -nr "\]" $infile | sed 's/:.*//g' > $infile.l2

[ -e $infile.fcn1 ] && rm -f $infile.fcn1
paste -- "$infile.l1" "$infile.l2" |
while IFS=$'\t' read -r file1 file2 rest; do
  #echo "$file2 - $file1"
  echo `expr $file2 - $file1` >> $infile.fcn1
done


[ -e $infile.fcn2 ] && rm -f $infile.fcn2
cat $infile2 | while read LINE
do
  echo $LINE | grep -o " " | wc -l >> $infile.fcn2
done

[ -e $infile.clean ] && rm -f $infile.clean
[ -e $infile.noisy ] && rm -f $infile.noisy
[ -e $infile2.clean ] && rm -f $infile2.clean
[ -e $infile2.noisy ] && rm -f $infile2.noisy

line_index=1
paste -- "$infile.fcn1" "$infile.fcn2" |
while IFS=$'\t' read -r file1 file2 rest; do
  diff=$(echo `expr $file1 - $file2`)
  if [ "$diff" -eq 0 ]
  then
    utt_key=$(sed -n $line_index"p" $infile2 | awk '{print $1}')
    python onmt/ExtractSingleSrcFrame.py $infile $utt_key >> $infile.clean
    grep "$utt_key" $infile2 >> $infile2.clean
  fi
  if [ "$diff" -lt 2 ]
  then
    utt_key=$(sed -n $line_index"p" $infile2 | awk '{print $1}')
    python onmt/ExtractSingleSrcFrame.py $infile $utt_key >> $infile.noisy
    grep "$utt_key" $infile2 >> $infile2.noisy
  fi
  line_index=$((line_index+1))
done

rm -f $infile.l1 $infile.l2 $infile.fcn1 $infile.fcn2 
