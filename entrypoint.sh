#!/bin/bash
set -o errexit

# Require MINECRAFT_VERSION environment variable to be set (no default assumed)
if [ -z "$MINECRAFT_VERSION" ]; then
  echo "Expecting environment variable MINECRAFT_VERSION to be set to non-empty string. Exiting."
  exit 1
fi

# Download Minecraft client .jar (Contains textures used by Minecraft Overviewer)
wget https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar -P ~/.minecraft/versions/${MINECRAFT_VERSION}/

while :
do
	# Run the world renders (One pass to make map, one to generate points of interests)
	overviewer.py --config /home/minecraft/config.py
	overviewer.py --config /home/minecraft/config.py --genpoi

	# Sleep for 5 minutes, then render again
	echo "Sleeping for 5 minutes"
	sleep 300
done
