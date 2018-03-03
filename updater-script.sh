#!/usr/bin/env bash
# TODO check ANDROID_SDK
export PATH=$ANDROID_SDK/build-tools/19.1.0/:$PATH

echo "Dump images"
adb pull /dev/block/mmcblk0p1 boot.img
adb pull /dev/block/mmcblk0p5 system.img

echo "Delete old image..."
rm *.rooted.img
cp system.img system.rooted.img
ROOT=$(pwd)

echo "Unpack boot"
mkdir -p target/boot
cd target/boot
../../bin/unpackbootimg -i ../../boot.img
mkdir ramdisk
cd ramdisk
zcat ../boot.img-ramdisk.gz | cpio -idmv
cd $ROOT

echo "Enable adb"
sed -i -- s/persist.sys.usb.config=.\*/persist.sys.usb.config=mtp,adb/ target/boot/ramdisk/default.prop

echo "Rebuild boot"
cd target/boot/ramdisk
find . | cpio --create --format='newc' | gzip > ../mod_ramdisk.img
cd ..
../../bin/mkbootimg \
    --kernel boot.img-zImage \
    --ramdisk mod_ramdisk.img \
    --cmdline "$(cat boot.img-cmdline)" \
    --base $(cat boot.img-base) \
    --pagesize $(cat boot.img-pagesize) \
    --kernel_offset $(cat boot.img-kerneloff) \
    --ramdisk_offset $(cat boot.img-ramdiskoff) \
    --second_offset $(cat boot.img-secondoff) \
    --tags_offset $(cat boot.img-tagsoff) \
    --hash $(cat boot.img-hash) \
    -o ../../boot.rooted.img
# TODO check file size it cannot over 6mb
cd $ROOT

echo "Mounting system..."
mkdir -p target/system
sudo mount -t ext4 -o loop system.rooted.img target/system

echo "Copying files..."
sudo cp -r overlay/* target/system
sync

# TODO fixme app theme light

echo "Disk usage..."
df | grep target

echo "Unmounting system..."
sudo umount target/system
rm -rf target

echo "Push images"
adb push *.rooted.img /sdcard

echo "Flash images"
# TODO: wait confirm
adb shell dd if=/sdcard/boot.rooted.img of=/dev/block/mmcblk0p1
adb shell dd if=/sdcard/system.rooted.img of=/dev/block/mmcblk0p5

echo "Install superuser"
adb push supersu-2.79.zip /sdcard
adb shell cp /etc/*.fstab /etc/fstab
adb shell cp /system/bin/busybox /sbin
adb shell cp /system/bin/unzip /sbin
adb shell mkdir /tmp/supersu
adb shell unzip /sdcard/supersu-2.79.zip META-INF/* -d /tmp/supersu
adb shell busybox sh /tmp/supersu/META-INF/com/google/android/update-binary dummy 1 /sdcard/supersu-2.79.zip
adb

echo "Remove used files"
adb shell rm /sdcard/*.rooted.img
adb shell rm /sdcard/supersu-2.79.zip

echo "Installation complete!"
adb shell reboot
