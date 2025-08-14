#!/bin/bash

if [[ -n "${CINTENT_ENABLED}" ]]; then
  /bin/bash "$@"
else
  export CINTENT_ENABLED=true

  log=${{ env.CINTENT_LOG }}/$(date +%s%N)
  sudo opensnoop-bpfcc >> $log &
  pid=$!
  
  start_time=$SECONDS
  until [ -s "$log" ] || (( SECONDS - start_time >= 60 )); do
    sleep 1
  done
  
  if [ ! -s "$log" ]; then
    echo "opensnoop failed to start!" 1>&2
    exit 1
  fi
  
  /bin/bash "$@"
  kill "$pid"
  unset CINTENT_ENABLED
fi
