#! /usr/bin/python2.7
# -*- coding: utf-8 -*-

"""
The `.smi` files should be in the `./smi` folder.
Extracted text will be contained in `.txt` files and located in a `./txt' folder.
"""

import html5lib
import os
from glob import glob

directory = '''./smi/'''
xpaths = "//body//text()"

def get_filenames(directory):
    return glob(os.path.join(directory, '*'))

def get_xpaths(filename):
    with open(filename, 'r') as f:
        p = html5lib.HTMLParser(\
                tree=html5lib.treebuilders.getTreeBuilder("lxml"),\
                namespaceHTMLElements=False)
        page = p.parse(f)
        xp = page.xpath(xpaths)
        return xp

def print_lines(filename, lines):
    with open(filename, 'w') as f:
        for line in lines:
            f.write(line)

filenames = get_filenames(directory)

for oldfile in filenames:
    newfile = 'txt' + oldfile[5:-4] + '.txt'
    print 'processing ' + oldfile
    lines = get_xpaths(oldfile)    
    encoded = (line.encode('utf-8') for line in lines)
    print_lines(newfile, encoded)
    print 'done'
