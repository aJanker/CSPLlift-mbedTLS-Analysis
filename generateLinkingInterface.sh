#!/bin/bash

path=$(cd "$(dirname "$0")"; pwd)

rm CModuleInterface.interface

$path/../CSPLlift/lift.sh  --mergeLinkingInterface $path
