#!/system/bin/sh
# --- Fix SetupWizard
su -c settings put secure user_setup_complete 1 
su -c settings put global device_provisioned 1
# --- Fix broken wifi
su -c settings put global restricted_networking_mode 0