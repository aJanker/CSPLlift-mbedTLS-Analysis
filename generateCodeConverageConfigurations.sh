#!/bin/bash

path=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=casestudy/filelist
  cat $listFile
}

./clean.sh

flags=" --bdd \
  	--platfromHeader $path/../TypeChef-GNUCHeader/platform.h \
	-I $path/../TypeChef-GNUCHeader/usr_include/ \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu \
	--openFeat $path/casestudy/openfeatures --featureModelFExpr $path/casestudy/model.fm \
	-I $path/include \
	-I $path/library \
  	--serializeAST --recordTiming --parserstatistics --lexNoStdout "


filesToProcess|while read i; do
         echo "Analysing $path/$i"
         echo "With settings: $flags"
         generateCodeConverageConfigurations_run.sh  $path/$i $flags
	#sbatch -p chimaira  -A spl -n 1 -c 2 --exclude=chimaira17 --time=06:00:00  --mem_bind=local --output=/dev/null --error=/dev/null $path/../TypeChef/typechef.sh $path/$i $flags
	done
