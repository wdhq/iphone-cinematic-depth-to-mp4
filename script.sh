#!/bin/bash

# Prompt for input file name
printf "\n ╭────────────────────────────────╮\n │ \e[1miPhone Cinematic Depth to .MP4\e[0m │\n╭┴─────────────────╮ ╭─────────╮  │\n│ \e[1mExample\e[0m \e[4;32mIMG_0000\e[0m ├─╯  \033[1m\033[35m@\033[38;5;93mw\033[34md\033[38;5;27mh\033[36mq\033[0m  ╰──╯\n╰──────────────────╯\n  \e[1mInput the file name →\e[0m "
read var

# Extract and manipulate video tracks from the input .mov file
MP4Box -add self#2:hdlr=vide ${var}.mov -out ${var}_hdlr.mp4

# Convert the video to HEVC codec, scale to 1920x1080, and output it as depth-map
ffmpeg -vcodec hevc -i ${var}_hdlr.mp4 -map 0:1 -filter:v scale=1920:1080 ${var}_depth-map.mp4

# Overlay the depth map video onto the original video and produce a new file
ffmpeg -i ${var}.MOV -i ${var}_depth-map.mp4 -filter_complex "[0:v][1:v] overlay=0:0" -an ${var}-2.MP4

# Clean up intermediate files
rm ${var}_hdlr.mp4
rm ${var}_depth-map.mp4

# Print completion message
printf "\n╭──────────────────╮\n│ \e[1mExport\e[0m \e[4;32mCompleted\e[0m │\n╰──────────────────╯\n"
