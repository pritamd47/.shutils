# Usage: bash initscience.sh <project_name> [--local_env]
# version 0.2: --local_env flag can be used to initialize a local environment with science-y
#              packages preinstalled
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
# If --local_env is passed, a local environment will be created inside the project directory
#    |- .condaenv/
#  * with `mamba`, `matplotlib`, `numpy`, `xarray`, `pandas`, and `rasterio` pre-installed. 
#  * conda-forge will be added as a channel
#  * the src/ directory will be added to conda path, so packages defined inside can be imported
#    when the environment is activated

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
echo ".condaenv/" >> .gitignore

if [ "$2" = "--local_env" ]; then
    echo "Initializing local environment"
    conda create --prefix "./.condaenv" -c conda-forge mamba -y
    source ./.condaenv/bin/activate ./.condaenv
    conda config --add channels defaults     # https://www.biostars.org/p/9461665/
    conda config --add channels conda-forge
    conda install conda-build -y
    conda develop ./src/
    mamba update mamba -y
    mamba install numpy matplotlib xarray pandas rasterio -y
else
    echo "Not creating local environment"
fi

echo "Initialized $PROJNAME - Science Away!!"
