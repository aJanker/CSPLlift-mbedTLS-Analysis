#!/bin/bash
#SBATCH -D /scratch/janker/Masterarbeit/CSPLlift-mbedTLS-Analysis
#SBATCH --job-name=mbedTLS_code
#SBATCH --get-user-env

path=$(cd "$(dirname "$0")"; pwd)

$path/../TypeChef/typechef.sh $@
$path/../CSPLlift/lift.sh $1 --reuseAST --genCodeCovConfigs
