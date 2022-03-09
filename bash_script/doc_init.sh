#!/bin/bash

#############################################################################
# Create venv if not already available
############################################################################

RED='\033[0;31m'
NC='\033[0m' # No Color


# Validate current working directory is the top-level of the project (esmart-anvil-firmware/)
REQUIREMENT_TXT=requirements.txt
if ! test -f "$REQUIREMENT_TXT"; then
    echo -e "${RED}Please call the script from the top level of the project ${NC}"
    echo -e "${RED}eg. bash_script/doc_xxx.sh${NC}"
    exit -1
fi


# Initialise VENV if not already done
VENV_FOLDER=venv
if ! test -d "$VENV_FOLDER"; then
    echo "Creating virtual environment for building documentation"

    # Create venv
    python3.8 -mvenv venv
    # Source the venv
    source venv/bin/activate
    # Install requirement
    pip install -q -U setuptools
    pip install -q wheel pip-tools
    pip install -q -r requirements.txt
else
    # Source the venv
    source venv/bin/activate
fi
