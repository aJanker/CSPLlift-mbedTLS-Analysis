#!/bin/bash

path=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=evalutionFiles
  cat $listFile
}

flags=" --bdd \
  	--platfromHeader $path/../TypeChef-GNUCHeader/platform.h \
	-I $path/../TypeChef-GNUCHeader/usr_include/ \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu \
	--openFeat $path/casestudy/openfeatures --noFP --linkingInterface $path/CModuleInterface.interface \
	-I $path/include \
	-I $path/library \
        --spllift taint --spllift EVALSINGLE --spllift PRINTVARIANTS --spllift CALLGRAPH \
        --reuseAST"


filesToProcess|while read i; do
         echo "Analysing $path/$i"
         echo "With settings: $flags"
         $path/../CSPLlift/lift.sh  $path/$i $flags
	done
