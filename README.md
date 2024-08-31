# iPhone Cinematic Depth to .MP4

> [!IMPORTANT]
> Credit for the valuable method and research goes to <img style="height:12px;vertical-align:middle;" src="https://about.x.com/content/dam/about-twitter/x/brand-toolkit/logo-white.png.twimg.1920.png" alt=""> [@jankais3r](https://x.com/jankais3r/status/1442466943697489923) and [TakashiYoshinaga](https://github.com/TakashiYoshinaga/iPhoneCinematicDepthTo3D).

> Basically, I refined the process into a single, convenient Bash script. Where you'll just have to copy-paste and run.

## Requirements

| [GPAC2.2](https://gpac.io) | [FFmpeg](https://ffmpeg.org) |
| :-: | :-: |
| `brew install gpac` | `brew install ffmpeg` |
| LGPL-2.1 | GPL-2.0 |

## Setup

### iOS Camera Settings

###### <img style="height:10px;vertical-align:middle;text-align:center" src="https://help.apple.com/assets/65E21662495F1A6C8701F50A/65E21663EF8273BE1D0C2734/en_US/de26b8cef467bff3fb0e82c194a55e94.png" alt=""> Settings › Camera › Formats

Choose **High Efficiency** under the Camera Capture section.

### Desktop Photos App Settings

###### <img style="height:10px;vertical-align:middle;" src="https://help.apple.com/assets/65382CE37BB3E2BCF80ADABA/65382CE57BB3E2BCF80ADAC0/en_US/b27be11281d58d9597fabdfcc67a3060.png" alt=""> Photos › File › Export

Choose **Export Unmodified Original For 1 Video** or `⌥⌘E`.

> Using any other export method would remove the `com.apple.quicktime.video-map` type container.

## Instructions

> [!CAUTION]
> Please ensure the source file is a .MOV file.

### MacOS

1. Open a **New Terminal at Folder**
2. Copy the Bash script
3. **Run**
4. Follow on-screen instructions 
5. **Export Completed**

Output **Example** `IMG_0000-2.MP4`

```bash
printf "\n ╭────────────────────────────────╮\n │ \e[1;37miPhone Cinematic Depth to .MP4\e[0m │\n╭┴─────────────────╮ ╭─────────╮  │\n│ \e[1;37mExample\e[0m \e[4;32mIMG_0000\e[0m ├─╯  \033[1m\033[35m@\033[38;5;93mw\033[34md\033[38;5;27mh\033[36mq\033[0m  ╰──╯\n╰──────────────────╯\n  \e[1;37mInput the file name →\e[0m " var && read var && MP4Box -add self#2:hdlr=vide ${var}.mov -out ${var}_hdlr.mp4 && ffmpeg -vcodec hevc -i ${var}_hdlr.mp4 -map 0:1 -filter:v scale=1920:1080 ${var}_depth-map.mp4 && ffmpeg -i ${var}.MOV -i ${var}_depth-map.mp4 -filter_complex "[0:v][1:v] overlay=0:0" -an ${var}-2.MP4 && rm ${var}_hdlr.mp4 && rm ${var}_depth-map.mp4 && printf "\n╭──────────────────╮\n│ \e[1mExport\e[0m \e[4;32mCompleted\e[0m │\n╰──────────────────╯\n"
```

## Troubleshooting

Below is a detailed breakdown of the Bash script you're running on your machine.

> Refer to the FFmpeg documentation for guidance on relevant topics.
> - [Filters](https://ffmpeg.org/ffmpeg-filters.html)
> - [Codecs](https://www.ffmpeg.org/ffmpeg-codecs.html)

```bash
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
```
