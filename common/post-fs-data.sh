#!/system/bin/sh
MODDIR=${0%/*}
write /proc/sys/vm/page-cluster 0
write /sys/block/zram0/max_comp_streams 4

setprop ro.vendor.qti.config.zram true