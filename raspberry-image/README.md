## Updating a raspbian lite image to w3d

For now you need to run this on a Raspberry Pi.

```bash
ZIP=raspbian_lite_latest
cd $W3D_REPO/raspberry_image/update-image
wget https://downloads.raspberrypi.org/$ZIP
unzip $ZIP
IMG=``unzip -l $ZIP | grep .img | awk '{ print $4 }'`
sudo ./update.sh $IMG
echo $IMG
```
Wirte the image to a (new) micro SD card:
```
sudo dd bs=4M if=$IMG of=/dev/sdX
sudo sync
```

Now boot the new image on a Raspberry Pi 3.

## Configure the Pi

1. On you computuer, create a file named `pi.conf` with the following layout:
```
[pi]
hostname=YOUR_FANCY_HOSTNAME
ssid=SSID_YOU_WANT_PI_TO_CONNECT_TO
psk=PASSPHRASE_OF_THE_WIFI
```

2. Copy `pi.conf` onto the top level directory of an USB drive.
3. Plug the USB drive into your Raspberry Pi
  * you should see the green light blinking
  * wait until the green light stops blinking
  * restart the Raspberry Pi by cutting the power
4. Your Raspberry Pi is connected to the `SSID_YOU_WANT_PI_TO_CONNECT_TO` wifi
5. If you computer supports [mDNS](https://en.wikipedia.org/wiki/Multicast_DNS)
   you should be able to acces the Raspberry Pi via `YOUR_FANCY_HOSTNAME.local`
