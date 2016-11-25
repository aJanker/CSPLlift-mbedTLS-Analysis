#!/bin/bash
#SBATCH -D /scratch/janker/Masterarbeit/CSPLlift-mbedTLS-Analysis
#SBATCH --job-name=mbedTLS_code
#SBATCH -p chimaira
#SBATCH -A spl
#SBATCH --get-user-env
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=15360
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=janker@fim.uni-passau.de
#SBATCH --mem_bind=local
#SBATCH --output=/scratch/janker/Masterarbeit/CSPLlift-mbedTLS-Analysis/log/run_%j
#SBATCH --error=/scratch/janker/Masterarbeit/CSPLlift-mbedTLS-Analysis/log/err_%j
#SBATCH --time=24:00:00
#SBATCH --array=0-50

path=$(pwd)

flags=" --bdd \
  	--platfromHeader $path/../TypeChef-GNUCHeader/platform.h \
	-I $path/../TypeChef-GNUCHeader/usr_include/ \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
	-I $path/../TypeChef-GNUCHeader/x86_64-linux-gnu \
	--openFeat $path/casestudy/openfeatures --noFP --linkingInterface $path/CModuleInterface.interface \
	-I $path/include \
	-I $path/library \
        --spllift taint --spllift EVALCOVERAGE --spllift PRINTVARIANTS --spllift CALLGRAPH \
        --reuseAST"

configId=${SLURM_ARRAY_TASK_ID}
i=`cat evaluationFiles | head -n $((configId + 1)) | tail -n1`
echo $i
time $path/../CSPLlift/lift.sh $path/$i $flags >  $path/$i.out_code.dbg 2>&1
