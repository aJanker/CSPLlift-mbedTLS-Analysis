#!/bin/sh

path=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=aes  
    cat $listFile
    }

flags="--bdd --featureModelFExpr /home/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/casestudy/model.fm \
--platfromHeader /home/janker/Masterarbeit/TypeChef-GNUCHeader/platform.h \
-I /home/janker/Masterarbeit/TypeChef-GNUCHeader/usr_include/ \
-I /home/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
-I /home/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
-I /home/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu \
--openFeat /home/janker/Masterarbeit/TypeChef-GNUCHeader/openfeatures.txt \
-I /home/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/include \
-I /home/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/library \
--bdd \
--spllift taint \
--reuseAST \
--recordTiming \
--linkingInterface /home/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/CModuleInterface.interface"


filesToProcess|while read i; do
    ../CSPLlift/lift.sh /home/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/$i $flags
done
