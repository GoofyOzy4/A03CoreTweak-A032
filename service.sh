#!/system/bin/sh
# - ZRam props
ZRAM_DIRTY_RATIO=5
ZRAM_DIRTY_BG_RATIO=15
ZRAM_SWAPINNES=140
# --- Scripts after dull booting
{
    until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
        sleep 3
    done
   # --- Set ZRam props
   echo "$ZRAM_DIRTY_RATIO" > /proc/sys/vm/dirty_ratio
   echo "$ZRAM_DIRTY_BG_RATIO" > /proc/sys/vm/dirty_background_ratio
   echo "$ZRAM_SWAPINNES" > /proc/sys/vm/swappiness
   # --- Fix SetupWizard
   su -c settings put secure user_setup_complete 1 
   su -c settings put global device_provisioned 1
}&
# --- Charging Fix
# - Function to set voltage
set_voltage() {
    echo 3000000 > /sys/class/power_supply/bq2560x_charger/constant_charge_current
    echo 3000000 > /sys/class/power_supply/bq2560x_charger/input_current_limit
}

# - Call the function at boot
set_voltage

# - Loop
while true; do
    set_voltage
    sleep 60
done
