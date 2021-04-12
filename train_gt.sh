## Ask user what step they are on (Preprocess, Train). Use flags and functions?
# Run Drew's scripts to convert, process and segment a set of new images.
# Place the tif and gt.txt files in the data folder.
# Ask if tif and gt files are edited...abort if not.
# Begin training.
train () {
	echo -e "All desired image and ground truth duo training files (*.tif, *.gt.txt) MUST be placed in the data directory."
	read -p "Continue? [y/n] " response
	[[ ${response} =~ ^[nN]$ ]] && exit
	
	
	echo
	read -p "Enter the name of your model > " model_name
	read -p "Enter the name of the model you wish to continue training from > " start_model
	make training MODEL_NAME=${model_name} START_MODEL=${start_model} PSM=7 TESSDATA=`pwd`/tesseract/tessdata
}

preprocess () {
	echo "Preprocessing"
}

print_usage () {
	echo "Usage: ./train_gt.sh [OPTION]..."
	echo "Train Tesseract on image data using the 'tesstrain' repository and Make."
	echo
	echo "  -p		Run preprocessing files and scripts on image data."
	echo "  -t		Begin training using tif/gt.txt file pairs.. (Uses ./data/<model-name>-ground-truth directory by default)"
}

# Options
SHORT=hp:t:
LONG=help,preprocess:,train:

OPTS=$(getopt --options $SHORT --long $LONG --name "$0" -- "$@")

if [ $? != 0 ] ; then echo -e "Failed to parse options ...\nAbort." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

# Defaults
PREPROCESS=./data

while getopts hpt: flag
do
	case "${flag}" in
		h)
			print_usage;;
		p)
			preprocess;;
		t)
			train ${OPTARG};;
		*)
			echo -e "Invalid option: -$flag";;
	esac
done
