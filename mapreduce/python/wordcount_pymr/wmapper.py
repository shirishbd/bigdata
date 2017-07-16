#!/usr/bin/env python

import sys

for line in sys.stdin:   # input lines from STDIN
	line = line.strip()   # removing trailing and leading spaces, if any
	words = line.split()  # split the line into words based on default delimitor (space)

	for word in words:
		print '%s\t%s' % (word,1)   # word is the KEY, 1 is the VALUE (default separator is TAB)

