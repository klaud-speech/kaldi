#!/usr/bin/python

import sys

fin = open(sys.argv[1])

found=0
for line in fin:
  line = line.rstrip()

  if found==1:
    if ']' in line:
      print(line)
      break

  if found==1:
    print(line)

  if found==0:
    if '[' in line:
      line2 = line.split(' ')
      if line2[0] == sys.argv[2]:
        found = 1
        print(line)

fin.close()
