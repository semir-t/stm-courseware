#!/bin/bash

#############################################################################
# Monitor documentation src (ressources/doc_source)
# and build documentation on (docs/) when change are detected)
#############################################################################

# Run initial build
source bash_script/doc_build.sh

# open the browser (if known)

if which google-chrome; then
    google-chrome docs/index.html &

elif which firefox; then
    firefox docs/index.html &

else
    echo "Browser unknown, you can manually open docs/index.html"

fi

# Start the watcher
sphinx-autobuild  ressources/docs_source/ docs/
