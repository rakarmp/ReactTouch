#!/system/bin/sh
MODDIR=${0%/*}

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor performance
write /sys/devices/system/cpu/cpufreq/performance/above_hispeed_delay 0
write /sys/devices/system/cpu/cpufreq/performance/boost 1
write /sys/devices/system/cpu/cpufreq/performance/go_hispeed_load 75
write /sys/devices/system/cpu/cpufreq/performance/max_freq_hysteresis 1
write /sys/devices/system/cpu/cpufreq/performance/align_windows 1
write /sys/module/adreno_idler/parameters/adreno_idler_active 0
write /sys/module/lazyplug/parameters/nr_possible_cores 8
write /sys/module/msm_performance/parameters/touchboost 1
write /dev/cpuset/foreground/boost/cpus 4-7
write /dev/cpuset/foreground/cpus 0-3,4-7
write /dev/cpuset/top-app/cpus 0-7

while [ `getprop vendor.post_boot.parsed` != "1" ]; do
    sleep 1s
done

sleep 10s

# Virtual Memory Tweaks Set Config
stop perfd
echo '5' > /proc/sys/vm/swappiness;
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk;
echo '80' > /proc/sys/vm/vfs_cache_pressure;
echo '0' > /proc/sys/vm/extra_free_kbytes;
echo '128' > /sys/block/mmcblk0/queue/read_ahead_kb;
echo '128' > /sys/block/mmcblk1/queue/read_ahead_kb;
echo '1024' > /sys/block/ram0/queue/read_ahead_kb
echo '1024' > /sys/block/ram1/queue/read_ahead_kb
echo '1024' > /sys/block/ram2/queue/read_ahead_kb
echo '1024' > /sys/block/ram3/queue/read_ahead_kb
echo '1024' > /sys/block/ram4/queue/read_ahead_kb
echo '1024' > /sys/block/ram5/queue/read_ahead_kb
echo '1024' > /sys/block/ram6/queue/read_ahead_kb
echo '1024' > /sys/block/ram7/queue/read_ahead_kb
echo '1024' > /sys/block/ram8/queue/read_ahead_kb
echo '1024' > /sys/block/ram9/queue/read_ahead_kb
echo '1024' > /sys/block/ram10/queue/read_ahead_kb
echo '1024' > /sys/block/ram11/queue/read_ahead_kb
echo '1024' > /sys/block/ram12/queue/read_ahead_kb
echo '1024' > /sys/block/ram13/queue/read_ahead_kb
echo '1024' > /sys/block/ram14/queue/read_ahead_kb
echo '1024' > /sys/block/ram15/queue/read_ahead_kb
echo '1024' > /sys/block/vnswap0/queue/read_ahead_kb
echo '4096' > /proc/sys/vm/min_free_kbytes;
echo '0' > /proc/sys/vm/oom_kill_allocating_task;
echo '5' > /proc/sys/vm/dirty_ratio;
echo '20' > /proc/sys/vm/dirty_background_ratio;
sleep 05
chmod 666 /sys/module/lowmemorykiller/parameters/minfree;
chown root /sys/module/lowmemorykiller/parameters/minfree;
echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree;
rm /data/system/perfd/default_values;
start perfd

setenforce 0
stop logd
stop thermald
echo always_on > /sys/devices/platform/13040000.mali/power_policy;
echo alweys_on > /sys/devices/platform/13040000.mali/gpuinfo;
echo alweys_support >/sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed;
echo alweys_support >/sys/devices/system/cpu/cpufreq/policy6/scaling_setspeed;
echo '1' > /sys/devices/system/cpu/sched/cpu_prefer;
echo boost > /sys/devices/system/cpu/sched/sched_boost;
echo '1' > /sys/devices/system/cpu/eas/enable;

#perf enable
echo '1' > /sys/devices/system/cpu/perf/enable;
chmod '0644' > /sys/devices/system/cpu/perf/enable;

echo 'boost' > /sys/devices/system/cpu/sched/sched_boost;
echo '3' > /proc/cpufreq/cpufreq_power_mode;
echo '1' > /proc/cpufreq/cpufreq_imax_enable;
echo '0' > /proc/cpufreq/cpufreq_imax_thermal_protect;
sleep 0.2
echo '35' > /dev/stune/foreground/schedtune.boost;
chmod '0444' /dev/stune/foreground/schedtune.boost;
echo '1' > /proc/cpufreq/cpufreq_cci_mode;
chmod '0444' /proc/cpufreq/cpufreq_cci_mode;

# Force GPU for touch render
echo '7035' > /sys/class/touch/switch/set_touchscreen;
echo '8002' > /sys/class/touch/switch/set_touchscreen;
echo '11000' > /sys/class/touch/switch/set_touchscreen;
echo '13060' > /sys/class/touch/switch/set_touchscreen;
echo '14005' > /sys/class/touch/switch/set_touchscreen;

# Google Service Reduce Drain Tweaks Set Config
sleep '0.001'
su -c 'pm enable com.google.android.gms'
sleep '0.001'
su -c 'pm enable com.google.android.gsf'
sleep '0.001'
su -c 'pm enable com.google.android.gms/.update.SystemUpdateActivity'
sleep '0.001'
su -c 'pm enable com.google.android.gms/.update.SystemUpdateService'
sleep '0.001'
su -c 'pm enable com.google.android.gms/.update.SystemUpdateServiceActiveReceiver'
sleep '0.001'
su -c 'pm enable com.google.android.gms/.update.SystemUpdateServiceReceiver'
sleep '0.001'
su -c 'pm enable com.google.android.gms/.update.SystemUpdateServiceSecretCodeReceiver'
sleep '0.001'
su -c 'pm enable com.google.android.gsf/.update.SystemUpdateActivity'
sleep '0.001'
su -c 'pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity'
sleep '0.001'
su -c 'pm enable com.google.android.gsf/.update.SystemUpdateService'
sleep '0.001'
su -c 'pm enable com.google.android.gsf/.update.SystemUpdateServiceReceiver'
sleep '0.001'
su -c 'pm enable com.google.android.gsf/.update.SystemUpdateServiceSecretCodeReceiver'

