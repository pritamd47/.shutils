# Usage: bash initscience.sh <project_name>
# version 0.1: By default add the date, future version will have option to disable having date
#              before the project name.
#
# Utility to initialize a science-y project directory at current directory
#  [date]<project_name>
#    |- bin/
#    |- data/
#    |- secrets/
#    |- src/
#    |- notebooks/
#    |- results/

PROJNAME=$(date +%Y_%m_%d)-$1
mkdir $PROJNAME
cd $PROJNAME
mkdir bin
mkdir data
mkdir secrets
mkdir src
mkdir notebooks
mkdir results
echo "Initialized $PROJNAME - Science Away!!"