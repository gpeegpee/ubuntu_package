#!/bin/sh
# $1 : obj/armeabi-v7a
adb logcat | ~/Android/Ndk/ndk-stack -sym $1
