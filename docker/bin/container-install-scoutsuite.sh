#!/bin/bash

# =====================================
# install ScoutSuite into a virtual env
# =====================================

WORKDIR=/root
TMPDIR=/tmp

# =====================================
# install ScoutSuite
# =====================================
cd ${WORKDIR}
git clone https://github.com/TiiSysDev/ScoutSuite.git
cd ScoutSuite
virtualenv -p python3 scoutsuite
source ${WORKDIR}/scoutsuite/bin/activate
pip install -r requirements.txt
python scout.py --help

echo -e "\n\nScoutsuite Installation Complete!\n\n"

