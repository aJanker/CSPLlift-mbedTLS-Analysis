#!/bin/bash
#SBATCH -D /scratch/janker/Masterarbeit/CSPLlift-mbedTLS-Analysis
#SBATCH --job-name=mbedTLS_code
#SBATCH --get-user-env

path=$(pwd)

$path/../TypeChef/typechef.sh $@
$path/../CSPLlift/lift.sh $1 --reuseAST --genCodeCovConfigs
