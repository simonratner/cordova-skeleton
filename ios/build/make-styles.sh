#!/bin/bash -e

# Build asset sources.

PATH=/usr/local/bin/:$PATH

# Source ruby environment, if any
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" && rvm use 1.9.2

# Make styles
outdir=${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/www
outfile=$outdir/application.css
mkdir -p $outdir
sprockets -I "$PROJECT_DIR/www" -I "$PROJECT_DIR/www/stylesheets" "$PROJECT_DIR/www/stylesheets/application.css" > $outfile

# TODO: Compress css output.