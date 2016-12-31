if [ "$1" = "off" ]; then
    /etc/init.d/vmware stop
    /etc/init.d/vmware-USBArbitrator stop

    exit 0
fi

/etc/init.d/vmware start
/etc/init.d/vmware-USBArbitrator start

