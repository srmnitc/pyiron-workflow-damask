#!/bin/bash
# install pyiron_continuum
git clone https://github.com/pyiron/pyiron_continuum.git
cd pyiron_continuum
pip install . 
cd ..
rm -rf pyiron_continuum

# execute notebooks
i=0;
for notebook in $(ls *.ipynb); do 
    papermill ${notebook} ${notebook%.*}-out.${notebook##*.} -k "python3" || i=$((i+1));
done;

# push error to next level
if [ $i -gt 0 ]; then
    exit 1;
fi;
