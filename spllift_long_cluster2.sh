#!/bin/sh
#SBATCH -D /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis
#SBATCH --job-name=spllift_long
#SBATCH -p chimaira
#SBATCH -A spl
#SBATCH --get-user-env
#SBATCH -n 1
#SBATCH -c 6
#SBATCH --mem=20480
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=janker@fim.uni-passau.de
#SBATCH --mem_bind=local
#SBATCH --output=/scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/log//run_%j
#SBATCH --error=/scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/log//err_%j
#SBATCH --time=24:00:00
#SBATCH --array=0-50
#SBATCH --exclude=chimaira12,chimaira13,chimaira14,chimaira15,chimaira16,chimaira17

path=$(pwd)

flags="--bdd  \
--platfromHeader /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/platform.h \
-I /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/usr_include/ \
-I /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
-I /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
-I /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/x86_64-linux-gnu \
--openFeat /scratch/janker/Masterarbeit/TypeChef-GNUCHeader/openfeatures.txt \
-I /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/include \
-I /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/library \
--bdd --noFP \
--spllift taint --spllift EVALSINGLE --spllift PRINTVARIANTS --spllift CALLGRAPH \
--reuseAST \
--recordTiming \
--linkingInterface /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/CModuleInterface.interface"

configId=${SLURM_ARRAY_TASK_ID}
i=`cat progs | head -n $((configId + 1)) | tail -n1`
echo $i
  time ../CSPLlift/lift.sh /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/$i $flags > /scratch/janker/Masterarbeit/TypeChef-mbedtlsAnalysis/$i.out2.dbg 2>&1
