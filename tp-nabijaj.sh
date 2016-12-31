#modprobe tp_smapi

#echo $#

echo -------------------------
#zaciatok=`cat /sys/devices/platform/smapi/BAT0/start_charge_thresh`
#koniec=`cat /sys/devices/platform/smapi/BAT0/stop_charge_thresh`
stav=`cat /sys/devices/platform/smapi/BAT0/remaining_percent`
#echo Aktualny stav je $stav% bude sa nabyjat: $zaciatok% - $koniec% 
echo Aktualny stav je $stav% bude sa nabyjat: 
/opt/bin/battery-get-charge-levels
echo -------------------------

echo "Kedy zacat nabijat? (napriklad: 50)"
if [ "$#" -eq "0" ]; then
    read start
else
    start="$1"
fi
#echo $start > /sys/devices/platform/smapi/BAT0/start_charge_thresh

echo "Kedy skoncit nabijat? (napriklad: 90)"
if [ "$#" -eq "0" ]; then
    read koniec
else
    koniec="$2"
fi

#echo $koniec > /sys/devices/platform/smapi/BAT0/stop_charge_thresh

sudo /opt/bin/tpacpi-bat -s ST 1 ${start}
sudo /opt/bin/tpacpi-bat -s SP 1 ${koniec}



echo -------------------------
#zaciatok=`cat /sys/devices/platform/smapi/BAT0/start_charge_thresh`
#koniec=`cat /sys/devices/platform/smapi/BAT0/stop_charge_thresh`
stav=`cat /sys/devices/platform/smapi/BAT0/remaining_percent`
#echo Aktualny stav je $stav% bude sa nabyjat: $zaciatok% - $koniec% 
echo Aktualny stav je $stav% bude sa nabyjat: 
/opt/bin/battery-get-charge-levels
echo -------------------------


