#!/bin/sh

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /home/gpeegpee/android_release_key.keystore $1 android_rel_key

adb install $1
