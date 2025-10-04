## goal

get a very minimal **arch linux + dwm** setup for my chromebook with the following specs:

| component | details |
|-----------|-----------------------------------------------|
| model     | chromebook phaser360                          |
| RAM       | 4 GB                                          |
| storage   | 32 GB eMMC                                    |
| CPU       | Intel(R) Celeron(R) N4000 (2) @ 2.60 GHz      |
| GPU       | Intel UHD Graphics 600 @ 0.65 GHz (Integrated)|

## steps

1. download the latest arch linux iso:

	```bash
	wget https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso
	```

2. flash the arch iso to a usb using balena etcher.

3. shut down the chromebook, then open it by pressing `esc + refresh + power`. press `ctrl + d` to boot into developer mode. after you are at the welcome screen, connect to the internet and use `ctrl + alt + f2` to get into a terminal. login using the user `chronos` and type in the command:

    ```bash
    curl -LO https://mrchromebox.tech/firmware-util.sh && sudo bash firmware-util.sh
    ```

    - use the firmware utility script to install a custom UEFI firmware:
      - after running the script, select the option to install/update full rom firmware (UEFI).
      - follow the on-screen prompts to back up your stock firmware and proceed with the installation.
      - once the process completes, reboot the chromebook to ensure the new firmware is active by booting and pressing `ctrl + l` or just `1` then `enter`. you will see a rabbit logo for the **coreboot**.
      - after that press esc and boot from the arch iso usb.

4. when you're at the terminal prompt that says `root@archiso ~ #`, run the command `iwctl` then run `help` and setup a wifi connection after `quit` run `ping google.com` to check if connected, u can press `ctrl + c` to get out of that.

5. get rid of chromeos
```bash
wipefs -a /dev/mmcblk0
```

6. run `archinstall` and folllow these
    - filesystem: f2fs
    - unified Kernel Image: Disabled
    - swap: zram enabled
    - profile: xorg
    - graphics driver: Intel drivers
    - bluetooth: enabled
    - audio: pipewire
    - kernel: linux-lts (use ctrl + c to get rid of linux)
    - time sync (NTP): enabled

7. reboot into the system after installation is complete and run this command
```bash
curl -fsSL https://raw.githubusercontent.com/ibrahimahtsham/arch-dwm/main/setup.sh | bash
```