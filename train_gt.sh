export TESSDATA_PREFIX=`pwd`/tesseract/tessdata

# Set the TESSDATA_PREFIX (changes made in the Makefile).
## Ask user what step they are on (Preprocess, Train). Use flags and functions?
# Run Drew's scripts to convert, process and segment a set of new images.
# Place the tif and gt.txt files in the data folder.
# Ask if tif and gt files are edited...abort if not.
# Begin training.

if [ -d ./data ]
then
	echo -e "\n\tFound data directory ...\n"
else
	echo -e "\n\tCreating data directory ...\n"
fi

read -p "All desired image and ground truth duo training files (*.tif, *.gt.txt) MUST be placed in the data directory. Continue? [y/n] " response
[[ ${response} =~ ^[nN]$ ]] && exit




read -p "Enter the name of the model you wish to continue training from > " start_model
model_name=`echo ssq_$(date '+%Y%m%d%H%M%S')`
make training MODEL_NAME=${model_name} START_MODEL=${start_model}
