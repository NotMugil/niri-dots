#!/bin/bash

# Define paths and commands
swayosd_client="swayosd-client"
output_device="alsa_output.pci-0000_11_00.4.analog-stereo.monitor"  # Example output device, adjust as needed

# Function to handle volume actions
volume_action() {
    action=$1
    case $action in
        raise)
            $swayosd_client --output-volume raise
            ;;
        lower)
            $swayosd_client --output-volume lower --device $output_device
            ;;
        mute-toggle)
            $swayosd_client --output-volume mute-toggle
            ;;
        +*)
            custom_value=${action#+}
            $swayosd_client --output-volume $custom_value
            ;;
        -*)
            custom_value=${action#-}
            $swayosd_client --output-volume -$custom_value
            ;;
        raise-max)
            $swayosd_client --output-volume raise --max-volume 120
            ;;
        lower-max)
            $swayosd_client --output-volume lower --max-volume 120
            ;;
        +*--device*)
            custom_value=${action#+}
            $swayosd_client --output-volume $custom_value --device $output_device
            ;;
        -*--device*)
            custom_value=${action#-}
            $swayosd_client --output-volume -$custom_value --device $output_device
            ;;
        *)
            echo "Invalid volume action"
            ;;
    esac
}

# Function to handle Caps Lock actions
caps_lock_action() {
    action=$1
    case $action in
        --caps-lock)
            $swayosd_client --caps-lock
            ;;
        --caps-lock-led*)
            led_name=${action#--caps-lock-led }
            $swayosd_client --caps-lock-led $led_name
            ;;
        *)
            echo "Invalid caps lock action"
            ;;
    esac
}

# Function to handle brightness actions
brightness_action() {
    action=$1
    case $action in
        raise)
            $swayosd_client --brightness raise
            ;;
        lower)
            $swayosd_client --brightness lower
            ;;
        +*)
            custom_value=${action#+}
            $swayosd_client --brightness +$custom_value
            ;;
        -*)
            custom_value=${action#-}
            $swayosd_client --brightness -$custom_value
            ;;
        *)
            echo "Invalid brightness action"
            ;;
    esac
}

# Main script logic based on passed arguments
case $1 in
    XF86AudioRaiseVolume)
        volume_action $2
        ;;
    XF86AudioLowerVolume)
        volume_action $2
        ;;
    XF86AudioMute)
        volume_action mute-toggle
        ;;
    XF86AudioMicMute)
        $swayosd_client --input-volume mute-toggle
        ;;
    Caps_Lock)
        caps_lock_action $2
        ;;
    XF86MonBrightnessUp)
        brightness_action $2
        ;;
    XF86MonBrightnessDown)
        brightness_action $2
        ;;
    *)
        echo "Unknown keybind: $1"
        ;;
esac

exit 0
