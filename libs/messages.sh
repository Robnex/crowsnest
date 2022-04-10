#!/bin/bash

#### message library

#### webcamd - A webcam Service for multiple Cams and Stream Services.
####
#### Written by Stephan Wendel aka KwadFan <me@stephanwe.de>
#### Copyright 2021
#### https://github.com/mainsail-crew/crowsnest
####
#### This File is distributed under GPLv3
####

# shellcheck enable=require-variable-braces

# Exit upon Errors
set -Ee

## Message Helpers

## core lib
function missing_args_msg {
    echo -e "webcamd: Missing Arguments!"
    echo -e "\n\tTry: webcamd -h\n"
}

function wrong_args_msg {
    echo -e "webcamd: Wrong Arguments!"
    echo -e "\n\tTry: webcamd -h\n"
}

function help_msg {
    echo -e "webcamd - webcam deamon\nUsage:"
    echo -e "\t webcamd [Options]"
    echo -e "\n\t\t-h Prints this help."
    echo -e "\n\t\t-v Prints Version of webcamd."
    echo -e "\n\t\t-c </path/to/configfile>\n\t\t\tPath to your webcam.conf\n"
}

function deprecated_msg_1 {
    log_msg "Parameter 'streamer' is deprecated!"
    log_msg "Please use mode: [ mjpg | rtsp | webrtc ]"
    log_msg "ERROR: Please update your webcam.conf! Stopped."
}

function unknown_mode_msg {
    log_msg "WARN: Unknown Mode configured!"
    log_msg "WARN: Using 'mode: mjpg' as fallback!"
}

function provides_omx_msg {
    if [ "$(check_omx)" -eq 1 ]; then
        log_msg "INFO: System provides OpenMAX IL features."
    else
        log_msg "WARN: System does not provide OpenMAX IL features."
    fi
}


## v4l2_control lib
function detected_broken_dev_msg {
    log_msg "WARN: Detected 'brokenfocus' device."
    log_msg "INFO: Trying to set to configured Value."
}

# call debug_focus_val_msg <value>
# ex.: debug_focus_val_msg focus_absolute=30
function debug_focus_val_msg {
    log_msg "DEBUG: Value is now: ${1}"
}
