#!/system/bin/sh
# --- Charger
echo 3000000 > /sys/class/power_supply/bq2560x_charger/constant_charge_current
echo 3000000 > /sys/class/power_supply/bq2560x_charger/input_current_limit

# --- ZRam
# - Parameters
ZRAM_SIZE=2G
ZRAM_SWAPINNES=180
# - Start tweak
zramctl --flush /dev/zram0
zramctl --reset /dev/zram0
sleep 3
echo lz4 > /sys/block/zram0/comp_algorithm
echo "$ZRAM_SIZE" > /sys/block/zram0/disksize
echo "$ZRAM_SWAPINNES" > /proc/sys/vm/swappiness
echo 0 > /sys/block/zram0/writeback
sleep 2.5
zramctl /dev/zram0

# --- Kernel Tweak
echo 0   0   0   0 > /proc/sys/kernel/printk
echo 0 > /proc/sys/kernel/printk_delay
echo 0 > /proc/sys/kernel/printk_ratelimit_burst
echo 0 > /proc/sys/kernel/printk_ratelimit
echo 0 > /proc/sys/kernel/dmesg_restrict
echo 0 > /sys/kernel/msm_thermal/enabled

# --- I/O Scheduler
# - Phone storage
echo noop > /sys/block/mmcblk0/queue/scheduler
# - SD-Card
echo noop > /sys/block/mmcblk1/queue/scheduler

# --- Network
echo 1 > /proc/sys/net/ipv4/tcp_low_latency
