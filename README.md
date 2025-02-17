# Subdivx Subtitle Downloader for mpv

This Lua script facilitates the retrieval of subtitles from subdivx.com for integration with the mpv media player.

## Prerequisites
* linux OS
* [mpv](http://mpv.io) player
* python with [subdivx-dl](https://github.com/csq/subdivx-dl)

## Usage

To use this script, follow these steps:

1. Save the Lua script to your mpv scripts directory, for example: `/home/{user}/.config/mpv/scripts/subdivx-get.lua`.
2. Run mpv with the script using the following command:
`mpv --script=/home/{user}/.config/mpv/scripts/subdivx-get.lua`

## How It Works

1. The script checks if the subtitle already exists in the directory.
2. If the subtitle does not exist, it searches for subtitles on subdivx.com.
3. Upon locating a subtitle, it is downloaded and incorporated into the mpv player.

## Key binding

* Press the `s` key to automatically fetch subtitles.

---
**Notes:**
* Make sure to replace `{user}` with your actual username in the file paths.  
* This script has only been tested on Linux systems.

## Other language
[Spanish](README_es.md)