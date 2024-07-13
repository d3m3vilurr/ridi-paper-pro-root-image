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

## App lists for 2024
recently (20240714), I updated my paper pro firmware to 1.6.4p with factory reset.
stupidly, I didn't backup my apps, it makes more time to ready for reading the book.

1. if you use old version without any problem, you don't need to update
    support SSL doesn't solve main problem that the device is too old and android version is too low.

    and also, 1.6.4p is not stable. I got a multiple app crashes which didn't get <= 1.5.4 version.

2. you cannot find compatible apps for the kitkat. so many apps were removed from the play store,
    and also so many web sites of apps were removed.

    [wayback machine][archive] and [f-droid archive][fd-archive] could be helpful for solving the problem.

[archive]: https://web.archive.org/
[fd-archive]: https://apt.izzysoft.de/fdroid/index.php?repo=archive

### Free apps
- [Librera Reader F-Droid][librera]; IDK reason, I can't use [f-droid built version][librera-fd].
- [MiXplorer][mix]
- [Orion Viewer][orion]
- [Perfect Viewer][perfect]; you would need apkmirror
- [Ultimate Dynamic Navbar][udn]; optional

### Non-free apps
if you use UDN or similar approach, probably you don't need this non-free apps.
but this chain is still convenience and useful.

- [Xposed Additions][xposed_add] and pro key; you might need to google or build from [source][xposed_add_source]
- [Tasker][tasker] and [Tasker App factory][tasker-appfactory]

[librera]: https://github.com/foobnix/LibreraReader/releases
[Librera-fd]: https://f-droid.org/packages/com.foobnix.pro.pdf.reader/
[mix]: https://mixplorer.com
[orion]: https://f-droid.org/en/packages/universe.constellation.orion.viewer/
[perfect]: https://play.google.com/store/apps/details?id=com.rookiestudio.perfectviewer&hl=en_US
[udn]: https://xdaforums.com/t/app-4-0-ultimate-dynamic-navbar.2270198/
[xposed_add_source]: https://github.com/SpazeDog/xposed-additions
[tasker-appfactory]: https://play.google.com/store/apps/details?id=net.dinglisch.android.appfactory&hl=en
