#!/usr/bin/python
# This script is to build target sequence 
# by interpolating phone sequneces provided by TIMIT corpus with the Kaldi framing scheme
# where 400 window samples and 160 shift samples at 16KHz
#
# ex) python seq2phn.py <feature file> <single phone sequence>
#
# The output is printed out as interploated up to the frame length of the corresponding featur length

import sys
import math

fin=open(sys.argv[1])
ts = fin.read()
fin.close()

ts = ts.split('\n')
ts = filter(None,ts)
ts_len = len(ts)
end_t = ts[ts_len-1]
end_t = end_t.split(' ')
end_t = int(end_t[1])
frame_len = int((end_t-240)/160)
timestamp=[]
start_bin=0
for t in range(frame_len):
  timestamp.append([start_bin,start_bin+400])
  start_bin = start_bin + 160

ps=sys.argv[2]+' '
fin = open(sys.argv[1])
end_t_backup=0
for line in fin:
  line = line.rstrip()
  line_split = line.split(' ')
  t1 = int(line_split[0])
  t2 = int(line_split[1])
  for i, tbin in enumerate(timestamp):
    if end_t_backup<tbin[1]:
      ps = ps + line_split[2] + ' '
      if tbin[1]+160>t2:
        end_t_backup=tbin[1]
        break

fin.close()
ps2 = ps.split(' ')
ps2 = filter(None,ps2)
print(" ".join(ps2))
