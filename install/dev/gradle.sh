#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

readonly VERSION=6.7
readonly STUFF=gradle-$VERSION-bin.zip

readonly TARGET_DIR=$HOME/dev/gradle
mkdir --parents $TARGET_DIR

readonly TEMP_DIR=$(mktemp --directory -t delete-me-XXXXXXXXXX)
(
  cd $TEMP_DIR

  echo -n Downloading...
  wget --quiet https://services.gradle.org/distributions/$STUFF
  echo done

  echo -n Extracting...
  unzip -qq $STUFF
  echo done

  echo -n Installing...
  mv --force gradle-$VERSION/* $TARGET_DIR
  echo done
)
rm --recursive --force $TEMP_DIR

echo -n Configuring...
sudo cp --force .profile.d.sh /etc/profile.d/profile.d.sh
mkdir --parents $HOME/.profile.d
echo "export GRADLE_HOME=$TARGET_DIR
export PATH=\$GRADLE_HOME/bin:\$PATH
" > $HOME/.profile.d/gradle.sh
echo done
