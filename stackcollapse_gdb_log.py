#!/usr/bin/python
# by Giovanni TATARANNI
# https://github.com/gtataranni

import fileinput, re
from collections import Counter

def extractFn(line):
	line = re.sub(r"^#[0-9]+ +", "", line)
	line = line.split(" (")[0]
	line = line.split(" in ")[-1]
	return line
l = []
s = ""
for line in fileinput.input():
	line.rstrip()
	if re.match(r"^Thread", line):
		l.append(s)
		s = ""
	elif re.match(r"^#0 ", line):
		l.append(s)
		s = extractFn(line)
	elif re.match(r"^#[1-9]", line):
		if s != "":
			s = ";" + s
		s = extractFn(line) + s
l.append(s)
cnt = Counter(l)
for x in cnt:
	print x, cnt[x]
