train () {
	echo
	echo "All desired image and ground truth duo training files (*.tif, *.gt.txt) MUST be placed in the data/<model-name>-ground-truth directory."
	read -p "Continue? [y/n] " response
	[[ ${response} =~ ^[nN]$ ]] && exit 1
	
	echo
	read -p "Enter a name to save your model to > " model_name
	read -p "Enter the name of the model/checkpoint you wish to continue training from > " start_model
	read -p "Enter the desired page segmentation mode > " psm
	make training MODEL_NAME=${model_name} START_MODEL=${start_model} PSM=${psm} TESSDATA=`pwd`/tesseract/tessdata
}

preprocess () {
	cd ./update
	[ ! -d ./data ] && { echo "ERROR: 'data' folder not found ..."; exit 1; }
	
	./conversion.sh
	python3 processing.py
	./segmentation.sh
}

print_usage () {
	echo "Usage: ./train_gt.sh [OPTION]..."
	echo "Train Tesseract on image data using the 'tesstrain' repository and Make."
	echo
	echo "  -h, --help			Display this help message."
	echo "  -p, --preprocess		Run preprocessing on image data. Image data must be placed in /update/data"
	echo "  -t, --train 			Begin training using .tif/.gt.txt file pairs."
}

# Defaults (if necessary)

while true;
do
	case "$1" in
		-h | --help )
			print_usage
			shift
			;;
		-p | --preprocess )
			preprocess
			shift
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
