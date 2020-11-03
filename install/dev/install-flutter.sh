#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

readonly VERSION=1.22.3
readonly STUFF=flutter_linux_$VERSION-stable.tar.xz

readonly TARGET_DIR=$HOME/dev/flutter
mkdir --parents $TARGET_DIR

readonly TEMP_DIR=$(mktemp --directory -t delete-me-XXXXXXXXXX)
(
  cd $TEMP_DIR

  echo -n Downloading...
  wget --quiet https://storage.googleapis.com/flutter_infra/releases/stable/linux/$STUFF
  echo done

  echo -n Extracting...
  tar --extract --file=$STUFF
  echo done

  echo -n Installing...
  shopt -s dotglob && mv --force flutter/* $TARGET_DIR
  echo done
)
rm --recursive --force $TEMP_DIR

echo -n Configuring...
sudo cp --force .profile.d.sh /etc/profile.d/profile.d.sh
mkdir --parents $HOME/.profile.d
echo "export FLUTTER_HOME=$TARGET_DIR
export PATH=\$FLUTTER_HOME/bin:\$PATH" > $HOME/.profile.d/flutter.sh
echo done