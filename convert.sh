#!/bin/bash

export FROM_DIR="/home/vazzda/sd/training/"
export TO_DIR="/home/vazzda/sd/stable-diffusion-webui/models/Stable-diffusion/"
export ORIGINAL_SCTPR_LOCATION="/home/vazzda/sd/diffusers/scripts/convert_diffusers_to_original_stable_diffusion.py"

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

function die {
    printf "Script failed: %s\n\n" "$1"
    exit 1
}

if [[ -z $model_name ]]; then
    die "Missing parameter --model_name"
elif [[ -z $base_model ]]; then
    die "Missing parameter --base_model"
elif [[ -z $steps ]]; then
    die "Missing parameter --steps"
fi


for i in ${steps[@]}; do
  MODEL_NAME="${model_name}__${base_model}__${i}.ckpt"
  COMMAND_TO_EXECUTE="${ORIGINAL_SCTPR_LOCATION} --model_path $FROM_DIR$i --checkpoint_path $TO_DIR$MODEL_NAME"

  echo "`tput setaf 1`Generating $MODEL_NAME`tput sgr0`"
  python3 $COMMAND_TO_EXECUTE
done

echo "`tput setaf 1`Done!`tput sgr0`"








#python ../../scripts/convert_diffusers_to_original_stable_diffusion.py --model_path "/" --checkpoint_path "/home/vazzda/sd/stable-diffusion-webui/models/Stable-diffusion/__tripple_SD1_5_001_3200.ckpt"



