#!/bin/bash

export PATH=/usr/bin:/bin:"$PATH"
export LC_ALL=UTF-8

ERROR_canNotAutoDetectXcodeprojFile=(1 "Sorry, couldn't locate the .xcodeproj file automatically. Please specify it with the -p option")
ERROR_noAppKeyProvided=(2 "Please specify the app key (use the -k switch)")
ERROR_illegalOption=(3 "Please use -h for help")

fail() {
  eval local error=('"${'$1'[@]}"')
  echo "${error[1]}" 1>&2
  exit ${error[0]}
}

analytic_id=0
analytics(){
  local query_params="application_key=${app_key}&$1=$2"
  local analytics_url="https://analytics.rollout.io/analytic/configure_pods"
  local curl_command="curl -sf"
  if [ "$analytic_id" == 0 ] ; then
    analytic_id="$($curl_command  "$analytics_url?$query_params" 2>/dev/null || echo 0)"
  else
    $curl_command "$analytics_url/$analytic_id?$query_params" 1>/dev/null 2>&1
  fi
}

BIN_DIR="$(cd "$(dirname "$0")" && pwd )"
BASE_DIR="$(dirname "$BIN_DIR")"
PROJECT_DIR="${BASE_DIR}/../.."
rollout_build=`(. "$BIN_DIR"/../lib/versions; echo $build)`

shopt -s nullglob

unset app_key help exit xcode_dir tweaker_before_linking
while getopts "p:k:lh" option; do
  case $option in
    k)
      app_key=$OPTARG
      ;;
    l)
      tweaker_before_linking=1
      ;;
    h)
      help=1
      ;;
    p)
      xcode_dir=$OPTARG
      ;;
    *)
      exit=1
      ;;
  esac
done

[ -z "$help" ] || {
  cat << EOF
Usage:
$0 <options>

  -k <app key>           Rollout app key (required)
  -p <.xcodeproj dir>    a path to the project directory (optional, for cases
                         in which the script cannot locate it automatically)
  -l                     set tweaker script phase before the linking phase
  -h                     this help message
EOF
  exit
}

[ -z "$exit" ] || fail ERROR_illegalOption

[ -n "$app_key" ] || fail ERROR_noAppKeyProvided
analytics rollout_sdk_ios_build_number $rollout_build

[ -n "$xcode_dir" ] || {
  dirs=("$PROJECT_DIR/"*.xcodeproj)
  [ ${#dirs[*]} == 1 ] || fail ERROR_canNotAutoDetectXcodeprojFile
  xcode_dir=${dirs[0]}
}

analytics project_file_selected true 
echo "Configuring project \"$xcode_dir\""

rm -rf "$PROJECT_DIR"/Rollout-ios-SDK
analytics  rm_exit_status $? 

"$BIN_DIR"/Installer "$xcode_dir" "$app_key"

exit_status=$?

analytics configure_pod_exit_status $exit_status 
exit $exit_status