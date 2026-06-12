#!/bin/bash

plemoljp_version="1.7.1"

BASE_DIR=$(cd $(dirname $0); pwd)

function mvBuild() {
  mkdir -p "${BASE_DIR}/build/PlemolSC"
  mkdir -p "${BASE_DIR}/build/PlemolSCConsole"
  mkdir -p "${BASE_DIR}/build/PlemolSC35"
  mkdir -p "${BASE_DIR}/build/PlemolSC35Console"
  mv -f "${BASE_DIR}/"PlemolSC35Console*.ttf "${BASE_DIR}/build/PlemolSC35Console/"
  mv -f "${BASE_DIR}/"PlemolSC35*.ttf "${BASE_DIR}/build/PlemolSC35/"
  mv -f "${BASE_DIR}/"PlemolSCConsole*.ttf "${BASE_DIR}/build/PlemolSCConsole/"
  mv -f "${BASE_DIR}/"PlemolSC*.ttf "${BASE_DIR}/build/PlemolSC/"
}

function mvBuildHS() {
  mkdir -p "${BASE_DIR}/build/PlemolSC_HS"
  mkdir -p "${BASE_DIR}/build/PlemolSCConsole_HS"
  mkdir -p "${BASE_DIR}/build/PlemolSC35_HS"
  mkdir -p "${BASE_DIR}/build/PlemolSC35Console_HS"
  mv -f "${BASE_DIR}/"PlemolSC35Console*.ttf "${BASE_DIR}/build/PlemolSC35Console_HS/"
  mv -f "${BASE_DIR}/"PlemolSC35*.ttf "${BASE_DIR}/build/PlemolSC35_HS/"
  mv -f "${BASE_DIR}/"PlemolSCConsole*.ttf "${BASE_DIR}/build/PlemolSCConsole_HS/"
  mv -f "${BASE_DIR}/"PlemolSC*.ttf "${BASE_DIR}/build/PlemolSC_HS/"
}

function mvBuildNF() {
  mkdir -p "${BASE_DIR}/build/PlemolSCConsole_NF"
  mkdir -p "${BASE_DIR}/build/PlemolSC35Console_NF"
  mv -f "${BASE_DIR}/"PlemolSC35Console*.ttf "${BASE_DIR}/build/PlemolSC35Console_NF/"
  mv -f "${BASE_DIR}/"PlemolSCConsole*.ttf "${BASE_DIR}/build/PlemolSCConsole_NF/"
  rm -f "${BASE_DIR}/"PlemolSC*.ttf
}

DEBUG_FLG='false'
while getopts d OPT
do
  case $OPT in
    'd' ) DEBUG_FLG='true';;
  esac
done

if [ "$DEBUG_FLG" = 'true' ]; then
  ("${BASE_DIR}/plemoljp_generator.sh" -d -v "$plemoljp_version" \
  && "${BASE_DIR}/os2_patch.sh" \
  && "${BASE_DIR}/copyright.sh" \
  && mvBuild)
  exit
fi

("${BASE_DIR}/plemoljp_generator.sh" -v "$plemoljp_version" \
&& "${BASE_DIR}/os2_patch.sh" \
&& "${BASE_DIR}/copyright.sh" \
&& mvBuild)

("${BASE_DIR}/plemoljp_generator.sh" -h -v "$plemoljp_version" \
&& "${BASE_DIR}/os2_patch.sh" \
&& "${BASE_DIR}/copyright.sh" \
&& mvBuildHS)

("${BASE_DIR}/plemoljp_generator.sh" -n -v "$plemoljp_version" \
&& "${BASE_DIR}/os2_patch.sh" \
&& "${BASE_DIR}/copyright.sh" \
&& mvBuildNF)
