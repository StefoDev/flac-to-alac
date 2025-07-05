#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
  echo "ffmpeg is not installed. Do you want to install it? (y/n)"
  read -r install_ffmpeg
  if [[ $install_ffmpeg == "y" ]]; then
    brew install ffmpeg
  else
    echo "ffmpeg is required to run this script. Exiting."
    exit 1
  fi
fi

# Check if AtomicParsley is installed
if ! command -v AtomicParsley &> /dev/null; then
  echo "AtomicParsley is not installed. Do you want to install it? (y/n)"
  read -r install_atomicparsley
  if [[ $install_atomicparsley == "y" ]]; then
    brew install atomicparsley
  else
    echo "AtomicParsley is required to run this script. Exiting."
    exit 1
  fi
fi

# Check and create required folders
for folder in input output processed; do
  if [ ! -d "$folder" ]; then
    mkdir "$folder"
    echo "Created folder: $folder"
  fi
done

echo "Please drop the files you want to convert into the 'input' folder."
echo "Press Enter when you are ready to proceed."
read -r

# Initialize counters
success_count=0
failure_count=0

# Process files in the input folder
for file in input/*.flac; do
  if [ -f "$file" ]; then
    base_name=$(basename "$file" .flac)
    output_file="output/${base_name}.m4a"
    artwork_file=$(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | head -n 1)

    # Convert FLAC to ALAC
    ffmpeg -i "$file" -vn -c:a alac "$output_file"
    if [ $? -eq 0 ]; then
      echo "Converted: $file -> $output_file"
      success_count=$((success_count + 1))

      # Apply artwork if available
      if [ -n "$artwork_file" ]; then
        AtomicParsley "$output_file" --artwork "$artwork_file" --overWrite
        echo "Applied artwork: $artwork_file -> $output_file"
      fi

      # Move original file to processed folder
      mv "$file" processed/
    else
      echo "Failed to convert: $file"
      failure_count=$((failure_count + 1))
    fi
  fi
done

# Summary
echo "Conversion complete."
echo "Successful conversions: $success_count"
echo "Failed conversions: $failure_count"
