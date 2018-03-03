#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/ChromeBookmarksSyncAdapter.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleCalendarSyncAdapter.apk
app/MediaUploader.apk
etc/permissions/com.google.android.ble.xml
etc/permissions/com.google.android.camera2.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/features.xml
framework/com.google.android.ble.jar
framework/com.google.android.camera2.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libAppDataSearch.so
lib/libconscrypt_gmscore_jni.so
lib/libgcastv2_base.so
lib/libgcastv2_support.so
lib/libgmscore.so
lib/libgms-ocrclient-v3.so
lib/libjgcastservice.so
lib/libjni_latinime.so
lib/libleveldbjni.so
lib/libNearbyApp.so
lib/libspeexwrapper.so
lib/libsslwrapper_jni.so
lib/libtango_utility_lib.so
lib/libvcdiffjni.so
lib/libvorbisencoder.so
lib/libwearable-selector.so
lib/libWhisper.so
priv-app/GMSCore.apk
priv-app/ConfigUpdater.apk
priv-app/GoogleBackupTransport.apk
priv-app/GoogleFeedback.apk
priv-app/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework.apk
priv-app/Phonesky.apk
priv-app/SetupWizard.apk
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Remove the Pico TTS app
    rm -f /system/app/PicoTts.apk

    # Remove the AOSP Stock Launcher after restore
    rm -f /system/priv-app/Launcher2.apk
    rm -f /system/priv-app/Launcher3.apk
    rm -f /system/app/Launcher2.apk
    rm -f /system/app/Launcher3.apk

    # Remove pieces from other GApps or ROM's (from updater-script)
    rm -f /system/app/BrowserProviderProxy.apk
    rm -f /system/app/GmsCore.apk
    rm -f /system/app/GoogleCalendar.apk
    rm -f /system/app/GoogleCloudPrint.apk
    rm -f /system/app/GoogleHangouts.apk
    rm -f /system/app/GoogleKeep.apk
    rm -f /system/app/GoogleOneTimeInitializer.apk
    rm -f /system/app/GooglePlus.apk
    rm -f /system/app/PartnerBookmarksProvider.apk
    rm -f /system/app/QuickSearchBox.apk
    rm -f /system/app/Talk.apk
    rm -f /system/app/Vending.apk
    rm -f /system/app/Youtube.apk
    rm -f /system/priv-app/Calendar.apk
    rm -f /system/priv-app/GmsCore.apk
    rm -f /system/priv-app/GoogleNow.apk
    rm -f /system/priv-app/QuickSearchBox.apk
    rm -f /system/priv-app/Vending.apk

    # Remove apps from 'app' that need to be installed in 'priv-app' (from updater-script)
    rm -f /system/app/CalendarProvider.apk
    rm -f /system/app/GoogleBackupTransport.apk
    rm -f /system/app/GoogleFeedback.apk
    rm -f /system/app/GoogleLoginService.apk
    rm -f /system/app/GooglePartnerSetup.apk
    rm -f /system/app/GoogleServicesFramework.apk
    rm -f /system/app/OneTimeInitializer.apk
    rm -f /system/app/Phonesky.apk
	rm -f /system/app/Provision.apk
    rm -f /system/app/PrebuiltGmsCore.apk
    rm -f /system/app/SetupWizard.apk
    rm -f /system/app/talkback.apk
    rm -f /system/app/Velvet.apk
    rm -f /system/app/Wallet.apk
;;
esac
