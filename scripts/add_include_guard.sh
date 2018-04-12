#!/bin/sh
sudo pip install guardonce
project=$1
python -m guardonce.guard2once -r .
python -m guardonce.once2guard -r -p "name| snake | upper| prepend $project" -s "#endif // %\n" .

