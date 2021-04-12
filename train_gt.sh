## Ask user what step they are on (Preprocess, Train). Use flags and functions?
# Run Drew's scripts to convert, process and segment a set of new images.
# Place the tif and gt.txt files in the data folder.
# Ask if tif and gt files are edited...abort if not.
# Begin training.
train () {
	if [ -d ./data ]
	then
		echo -e "\n\tFound data directory ...\n"
	else
		echo -e "\n\tCreating data directory ...\n"
	fi
	
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

while getopts pt flag
do
	case "${flag}" in
		p) preprocess
			;;
		t) train
			;;
		*) echo -e "Invalid option: -$flag"
			;;
	esac
done
