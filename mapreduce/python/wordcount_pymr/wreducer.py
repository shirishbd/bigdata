#!/usr/bin/env python

import sys

# Expected:
# (KEY, list(VALUE)) 
# (car, {1,1,1,1})
# (bar, {1,1})

# Actual: (because of hadoop-streaming)
# (car,1)
# (car,1)
# (car,1)
# (car,1)
# (bar,1)
# (bar,1)

ongoing_word = None
ongoing_count = 0
word = None
count = 0

for line in sys.stdin:
	line = line.strip()
	word,count = line.split('\t', 1)

	count = int(count)  # converting string "1" to integer 1
	
	if ongoing_word == word:
		ongoing_count += count
	else:
		if ongoing_word:   # there is actually an ongoing word (checks if ongoing_word = None, the initial value)
			print '%s\t%s' % (ongoing_word, ongoing_count)
		ongoing_word = word
		ongoing_count = count

if ongoing_word:
	print '%s\t%s' % (ongoing_word, ongoing_count)

