# Create custom recovery
Dump recovery image using adb

```bash
adb pull /dev/block/mmcblk0p2 mmcblk0p2.img
```

unpack img

```bash
mkdir unpack
cd unpack
../../bin/unpackbootimg -i ../mmcblk0p2.img
```

unpack ramdisk

```bash
mkdir ramdisk
zcat ../mmcblk0p2.img-ramdisk.gz | cpio -idmv
```

fill `system` directory and overwrite `adbd`

```
TBD
```

and modify `default.prop`

```
ro.secure=0
ro.debuggable=1
service.adb.root=1
persist.sys.usb.config=mtp,adb
```

repack ramdisk

```bash
find . | cpio --create --format='newc' | gzip > ../mod_ramdisk.img
```

repack recovery img

```
../../../bin/mkbootimg --kernel mmcblk0p2.img-zImage \
    --ramdisk mod_ramdisk.img \
    --cmdline "console=ttymxc0,115200 init=/init androidboot.console=ttymxc0 video=mxcepdcfb:E060SCM,bpp=16 video=mxc_elcdif_fb:off no_console_suspend" \
    --base 80800000 \
    --pagesize 2048 \
    --kernel_offset 00008000 \
    --ramdisk_offset 01000000 \
    --second_offset 00f00000 \
    --tags_offset 00000100 \
    --hash sha1 \
    -o mod_recovery.img
```
