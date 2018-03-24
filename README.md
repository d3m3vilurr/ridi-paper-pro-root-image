# Ridibooks Paper Pro rooting image generator

## Prerequire
```bash
$ git clone git://...
$ cd ridi-paper-pro-root-image
```

## How to use
Insert device id into `.android/adb_usb.ini`

```bash
$ echo 0x1f85 >> ~/.android/adb_usb.ini
```

Start fastboot mode

1. power off
2. hold right-up button + power button
3. device will shown green led (top edge, left of power button)
4. unhold buttons after changed white led

```bash
$ fastboot devices
PP1A1GK125241   fastboot
```

Run recovery
```bash
$ fastboot boot recovery/mod_recovery.img
```

Then follow remain steps

```bash
$ bash updater-script.sh
```

## After steps
If you first time use this rooting method, please run this.

```
$ adb shell am start -n com.hayaisoftware.launcher/.activities.SearchActivity
```

After first run, you should install button overlay app or button mapping app, it help
to start launcher at next boot time.

I suggest [Xposed Additions][xposed_add] for this. it can remap buttons and support double
and triple click.

[xposed_add]: https://play.google.com/store/apps/details?id=com.spazedog.xposed.additionsgb

And if not remap button using ridibooks viewer, you cannot use back button feature until use
another remap tool.

```bash
$ adb shell input keyevent 4
```

Also you can refresh screen manually using [epdblk][epdblk]. It should have compatibility with
[RefreshPie][RefreshPie]. (But I'm not use this tool anymore)

If you want to bind key, use [Tasker][tasker] and bind shortcut to Xposed Additions

[epdblk]: https://github.com/d3m3vilurr/epdblk
[RefreshPie]: https://github.com/ztoday21/refreshPie
[tasker]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm
