#!/bin/bash -e

#  Exclude asset sources from packaging.

PATH=/usr/local/bin/:$PATH

outdir=${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/www
find $outdir -type f \( \
             -name *.coffee -o \
             -name *.js -o \
             -name *.css -o \
             -name *.sass -o \
             -name *.scss \
          \) -delete
find $outdir -type d -empty -depth -delete
