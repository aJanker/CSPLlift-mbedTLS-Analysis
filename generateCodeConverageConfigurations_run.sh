#!/bin/bash

path=$(cd "$(dirname "$0")"; pwd)

$path/../TypeChef/typechef.sh $@
$path/../CSPLlift/lift.sh $1 --reuseAST --genCodeCovConfigs
