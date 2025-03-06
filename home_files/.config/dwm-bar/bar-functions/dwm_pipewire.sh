#!/bin/sh

dwm_pipewire () {
    STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

    raw_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
    percent_vol=$(echo "scale=0; $raw_vol * 100" | bc)
    VOL="${percent_vol%.*}"

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
    	if [ "$STATUS" = "[MUTED]" ]; then
	            printf "🔇"
    	else
    		#removed this line becuase it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	            printf "🔈 %s%%" "$VOL"
	        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	            printf "🔉 %s%%" "$VOL"
	        else
	            printf "🔊 %s%%" "$VOL"
	        fi
		fi
    else
    	if [ "$STATUS" = "[MUTED]" ]; then
    		printf "MUTE"
    	else
	        # removed this line because it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	            printf "VOL %s%%" "$VOL"
	        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	            printf "VOL %s%%" "$VOL"
	        else
	            printf "VOL %s%%" "$VOL"
        	fi
        fi
    fi
    printf "%s\n" "$SEP2"
}

dwm_pipewire
