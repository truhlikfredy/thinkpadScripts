#! /bin/bash

## Trackpoint settings

# When run from a udev rule, DEVPATH should be set
if [ ! -z $DEVPATH ] ; then
    TPDEV=/sys/$( echo "$DEVPATH" | sed 's/\/input\/input[0-9]*//' )
else
# Otherwise just look in /sys/
    TPDEV=$(find /sys/devices/platform/i8042 -name name | xargs grep -Fl TrackPoint | sed 's/\/input\/input[0-9]*\/name$//')
fi

# http://www.thinkwiki.org/wiki/How_to_configure_the_TrackPoint
# http://wwwcssrv.almaden.ibm.com/trackpoint/files/ykt3eext.pdf
#------------------------------------------------------------
if [ -d "$TPDEV" ]; then
    echo "Configuring Trackpoint - moje citlivosti" | tee >(logger -t "trackpoint-moj")
#    echo -n 255     > $TPDEV/sensitivity     # Integer  128   Sensitivity
#    echo -n 110     > $TPDEV/speed           # Integer  97   Cursor speed
#    echo -n 4       > $TPDEV/inertia         # Integer  6   Negative intertia
    echo -n 220     > $TPDEV/sensitivity     # Integer  128   Sensitivity
    echo -n 110     > $TPDEV/speed           # Integer  97   Cursor speed
    echo -n 4       > $TPDEV/inertia         # Integer  6   Negative intertia
    /usr/bin/xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 300  #stredny button mozem aj pomalsie kliknut a uzna to ako klik
else
    echo "Couldn't find trackpoint device $TPDEV na nastavenie mojej citlivosti" | tee >(logger -t "trackpoint-moj")
fi