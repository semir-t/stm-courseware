#!/bin/bash

#############################################################################
# Build documentation from (ressources/doc_source)
# and output the result to (docs/)
#############################################################################

# Setup venv if required
source bash_script/doc_init.sh

# build
sphinx-build  ressources/docs_source/ docs/