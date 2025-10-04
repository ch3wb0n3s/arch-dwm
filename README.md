## goal

get a very minimal **arch Linux + dwm** setup for my chromebook with the following specs:

| component | details |
|-----------|-------------------------------------------------------------|
| model     | chromebook phaser360                                                 |
| RAM       | 4 GB                                                        |
| storage   | 32 GB eMMC                                                  |
| CPU       | Intel(R) Celeron(R) N4000 (2) @ 2.60 GHz                    |
| GPU       | Intel UHD Graphics 600 @ 0.65 GHz (Integrated)              |

## steps

1) shutdown chromebook then open it by pressing esc + refresh + power press ctrl d to boot into developer mode after you are at the welcome screen connect to the internet and use ctrl alt f2 to get into a terminal, login using the user chronos and type in the command
```bash
curl -LO https://mrchromebox.tech/firmware-util.sh && sudo bash firmware-util.sh
```

2) get iso with this command:
```bash
wget https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso
```

3) flash arch iso to a usb using balena etcher