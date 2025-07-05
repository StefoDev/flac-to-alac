# FLAC to ALAC Conversion Script

## Description
This shell script automates the process of converting `.flac` audio files to `.m4a` (ALAC format) using `ffmpeg`. It also applies album artwork to the converted files using `AtomicParsley` if artwork files are available. The script ensures necessary tools are installed, sets up required folders, and provides a summary of successful and failed conversions.

## Features
- Checks for required tools (`Homebrew`, `ffmpeg`, `AtomicParsley`) and installs them if missing.
- Creates necessary folders (`input`, `output`, `processed`) if they don't exist.
- Converts `.flac` files in the `input` folder to `.m4a` (ALAC format).
- Applies album artwork (`.jpg`, `.jpeg`, `.png`) to the converted files.
- Moves processed `.flac` files to the `processed` folder.
- Provides a summary of successful and failed conversions.

## Requirements
- macOS
- Homebrew
- `ffmpeg` (installed via Homebrew)
- `AtomicParsley` (installed via Homebrew)

## Installation
1. Ensure Homebrew is installed on your system. If not, install it from [https://brew.sh](https://brew.sh).
2. Save the script as `flac-to-alac.sh`.
3. Make the script executable:
   ```bash
   chmod +x flac-to-alac.sh
   ```

## Usage
1. Run the script:
   ```bash
   ./flac-to-alac.sh
   ```
2. Follow the prompts:
    - Install missing tools if prompted.
    - Drop `.flac` files into the `input` folder.
    - Press Enter to start the conversion process.

## Folder Structure
- `input`: Place `.flac` files to be converted here.
- `output`: Converted `.m4a` files will be saved here.
- `processed`: Original `.flac` files will be moved here after conversion.

## Example Conversion
The script uses the following commands for conversion:
```bash
ffmpeg -i input.flac -vn -c:a alac output.m4a
AtomicParsley output.m4a --artwork cover.jpg --overWrite
```

## Summary
At the end of the process, the script provides:
- Number of successful conversions.
- Number of failed conversions.

## Notes
- Ensure artwork files (`.jpg`, `.jpeg`, `.png`) are in the same directory as the script for album art application.
- The script assumes all `.flac` files in the `input` folder are valid for conversion.

## License
This script is provided as-is and is free to use and modify.
