#!/bin/bash

export OUTPUT_DIR="/mnt/d/_dsk/YandexDisk/sd/_JUNK/"

while [ $# -gt 0 ]; do
  case "$1" in
    --tile*|-u*)
      if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
      TILE="${1#*=}"
      ;;
    *)
      >&2 printf "Error: Invalid argument\n"
      exit 1
      ;;
  esac
  shift
done


list_off_all_images=$(find $OUTPUT_DIR  -type f -iname "*.png")
for img in $list_off_all_images
do
  echo "Converting ${img}"
  convert                   \
    "${img}"               \
   -fill '#00FF00'               \
   -pointsize 32           \
   -gravity north-east          \
   -annotate 0 '%t' \
    "${img}_stamped.png"
done


non_empty_end_dir_list=$(find $OUTPUT_DIR  -type f -print0 | xargs -0 -n 1 dirname | sort -u)
for dir in $non_empty_end_dir_list
do
  echo "Montaging ${dir}"
  $(montage $dir/*_stamped.png -tile $TILE -geometry +0+0 $dir/all.png)
done

list_off_all_images_stampled=$(find $OUTPUT_DIR  -type f -iname "*_stamped.png")
for stamped_img in $list_off_all_images_stampled
do
  rm -rf $stamped_img
done


