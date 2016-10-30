#!/bin/sh

##########################################################
# swift-ffmpeg																					 #
#																												 #
# A fire-and-forget shell script that encodes 					 #
# multiple video and audio files with ffmpeg.            #
#																												 #
# Github: https://github.com/DonutDeflector/swift-ffmpeg #
##########################################################

##############################
# Settings

# Video Codec
# (libx264 or libx265)
# default: libx265
videocodec=libx265

# Rate Factor
# (0-51 | Lower Number = Higher Quality) 
# default: 21
ratefactor=21

# Preset
# (ultrafast, superfast, veryfast, fast, medium, slow, slower, veryslow)
# default: medium
preset=medium

# Pixel Format (chroma sampling and bit depth)
# (yuv420p [8bit], yuv420p10le [10bit])
# Default: yu4v2010le
pixelformat=yuv420p10le

# Audio Codec
# (ac3, eac3, wmav1, wmav2, libmp3lame, libfdk_aac, aac, libvorbis, vorbis, libopus)
# default: aac
audiocodec=aac

# Constant/Variable Bitrate
# (b:a for CBR | q:a for VBR)
# Default: b:a
audioencoding=b:a

# Constant Bitrate
# CBR (8k, 16k, 24k, 32k, 40k, 48k, 64k, 80k, 96k, 112k, 128k, 160k, 192k, 224k, 256k, or 320k)
# VBR (0-9 | Lower Number = Higher Quality)
# default: 256k
audiobitrate=256k # Very important to remember the 'k' for CBR

# Audio Channels
# default: 2
audiochannels=2

# Input Format
# (mp4, mkv, avi, etc.) 
# default: mp4
inputformat=mkv

# Output Format
# (mp4, mkv, avi, etc.) 
# default: mkv
outputformat=mp4

#########################

# Core Functionality
# (Better off not touching unless you know what you are doing)
for f in "$1"/*."$inputformat"; do ffmpeg -i "$f" -c:v "$videocodec" \
         -crf "$ratefactor" -preset "$preset" -c:a "$audiocodec" \
         -"$audioencoding" "$audiobitrate" -ac "$audiochannels" -pix_fmt "$pixelformat" \
         "${f%."$inputformat"}[sf]."$outputformat""; done