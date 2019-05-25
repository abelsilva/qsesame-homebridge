#!/bin/bash

cd /root/.homebridge

cp config.dist.json config.json
sed -i 's/{{HOMEBRIDGE_USER}}/'"${HOMEBRIDGE_USER}"'/' config.json
sed -i 's/{{HOMEBRIDGE_PIN}}/'"${HOMEBRIDGE_PIN}"'/' config.json
sed -i 's/{{LOCK_NAME}}/'"${LOCK_NAME}"'/' config.json
sed -i 's/{{SESAME_EMAIL}}/'"${SESAME_EMAIL}"'/' config.json
sed -i 's/{{SESAME_PASSWORD}}/'"${SESAME_PASSWORD}"'/' config.json

function sleepuntil() {
    local target_time="$1"
    today=$(date +"%m/%d/%Y")
    current_epoch=$(date +%s)
    target_epoch=$(date -d "$today $target_time" +%s)
    sleep_seconds=$(( $target_epoch - $current_epoch ))

    echo 'Waiting ' "${sleep_seconds}" ' seconds to force restart'

    sleep $sleep_seconds
}

function kill_homebridge(){
    local target_time="04:00";
    sleepuntil $target_time
    killall homebridge
}

kill_homebridge & 

homebridge
