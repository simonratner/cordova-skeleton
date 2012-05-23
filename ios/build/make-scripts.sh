#!/bin/bash -e

# Build asset sources.

PATH=/usr/local/bin/:$PATH

# Source ruby environment, if any
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" && rvm use 1.9.2

# Make scripts
outdir=${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/www
outfile=$outdir/application.js
mkdir -p $outdir
sprockets -I "$PROJECT_DIR/www" -I "$PROJECT_DIR/www/javascripts" "$PROJECT_DIR/www/javascripts/application.ios.js" > $outfile

plist=${INFOPLIST_FILE}
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $plist)
buildVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $plist)
buildConf=$(echo -n ${CONFIGURATION} | tr '[:upper:]' '[:lower:]')

uglifyjs --mangle-toplevel --no-copyright --overwrite -d "\$version\$='$buildVersion-$buildNumber-$buildConf'" $outfile
