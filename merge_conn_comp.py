#!/usr/bin/env python

import sys

def mergeFiles(files, output):
    file_list = []
    with open(output, 'w') as outfile:
        for fname in files.split(', '):
            with open(fname) as infile:
                for line in infile:
                    outfile.write(line)

if __name__=="__main__":
    mergeFiles(sys.argv[1], sys.argv[2])
