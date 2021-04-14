## Ask user what step they are on (Preprocess, Train). Use flags and functions?
# Run Drew's scripts to convert, process and segment a set of new images.
# Place the tif and gt.txt files in the data folder.
# Ask if tif and gt files are edited...abort if not.
# Begin training.
train () {
	echo -e "\nAll desired image and ground truth duo training files (*.tif, *.gt.txt) MUST be placed in the data/<model-name>-ground-truth directory."
	read -p "Continue? [y/n] " response
	[[ ${response} =~ ^[nN]$ ]] && exit
	
	
	echo
	read -p "Enter the name of your model > " model_name
	read -p "Enter the name of the model you wish to continue training from > " start_model
	read -p "Enter the desired segmentation mode > " psm
	make training MODEL_NAME=${model_name} START_MODEL=${start_model} PSM=${psm} TESSDATA=`pwd`/tesseract/tessdata
}

preprocess () {
	echo "Preprocessing in `echo $1`"
}

print_usage () {
	echo "Usage: ./train_gt.sh [OPTION]..."
	echo "Train Tesseract on image data using the 'tesstrain' repository and Make."
	echo
	echo "  -h, --help			Display this help message."
	echo "  -p, --preprocess <directory>	Run preprocessing files and scripts on image data. Default ./data"
	echo "  -t, --train 			Begin training using tif/gt.txt file pairs."
}

# Defaults
PREPROCESS=./data

# Add defaults for train


while true;
do
	case "$1" in
		-h | --help )
			print_usage
			shift
			;;
		-p | --preprocess )
			shift
			if [ -d "$1" ];
			then
				preprocess "$1"
				shift
			else
				preprocess "$PREPROCESS"
				shift
			fi
			;;
		-t | --train )
			train
			shift
			;;
		-* )
			echo -e "Invalid option!\nAbort."
			exit 1
			;;
		* )
			break
			;;
	esac
done
