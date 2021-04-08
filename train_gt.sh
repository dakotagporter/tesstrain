if [ -d ./data ]
then
	echo -e "\n\tFound data directory ..."
else
	echo -e "\n\tCreating data directory ..."
fi

echo -e "\nAll desired image and ground truth duo training files (*.tif, *.gt.txt) MUST be placed in the data directory"
