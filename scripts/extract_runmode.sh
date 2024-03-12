#!/usr/bin/env bash

mkdir -p output

input_file="linux_runmode.itb"
output_prefix="output/linux_runmode.entry"
offsets=(0 444 4012620 4024984 4037064 4049812 4062560 4074640 4087388 4099368 4111348 4123388 4136276 4148360 4161220 4173052 4184884 4196716 4207920 4220408 4233100 4245828 4257436)

for ((i=0; i<${#offsets[@]}; i++)); do
    entry_num=$((i+1))
    start_offset=${offsets[i]}
    end_offset=${offsets[i+1]}

    entry_file="${output_prefix}_${entry_num}"
    dd if="$input_file" of="$entry_file" bs=1 count=$((end_offset - start_offset)) skip="$start_offset"

    # Check if the entry is a Device Tree Blob
    if file -b "$entry_file" | grep -q "Device Tree Blob version 17"; then
        # Use dtc to convert DTB to DTS
        dtc -I dtb -O dts -o "${entry_file}.dts" "$entry_file"
    fi
done

# Run 'file' command on each entry
for entry_file in "${output_prefix}"_*; do
    echo -n "File type for ${entry_file}: "
    file "${entry_file}"
done

