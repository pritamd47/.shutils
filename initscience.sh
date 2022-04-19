# Usage: bash initscience.sh <project_name> <shell>
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
echo "Making the project directory - $PROJNAME"
mkdir $PROJNAME
cd $PROJNAME

echo "Making the project directory structure"
mkdir bin
mkdir data
mkdir secrets
mkdir src
mkdir notebooks
mkdir results

echo "Initializing git"
git init
touch .gitignore
echo "./.condaenv/" >> .gitignore


echo "Initializing environment"
conda create --prefix "./.condaenv" -c conda-forge mamba -y
source ./.condaenv/bin/activate ./.condaenv
conda config --add channels defaults     # https://www.biostars.org/p/9461665/
conda config --add channels conda-forge
conda install conda-build -y
conda develop ./src/
mamba update mamba -y
mamba install numpy matplotlib xarray pandas rasterio -y


echo "Initialized $PROJNAME - Science Away!!"