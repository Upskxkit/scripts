#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

readonly VERSION=4.6.1
readonly STUFF=mattermost-desktop-$VERSION-linux-x64.tar.gz

readonly TARGET_DIR=$HOME/programs/mattermost-desktop
mkdir --parents $TARGET_DIR

readonly TEMP_DIR=$(mktemp --directory -t delete-me-XXXXXXXXXX)
(
  cd $TEMP_DIR

  echo -n Downloading...
  wget --quiet https://releases.mattermost.com/desktop/$VERSION/$STUFF
  echo done

  echo -n Extracting...
  tar --extract --gzip --file=$STUFF
  echo done

  echo -n Installing...
  mv --force mattermost-desktop-$VERSION-linux-x64/* $TARGET_DIR
  echo done
)
rm --recursive --force $TEMP_DIR