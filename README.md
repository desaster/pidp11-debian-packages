# Unofficial PiDP-11 Debian packages

*This is an alternative distribution of the PiDP-11 software!*

This repository contains a shell script for downloading, building and
packaging simh with blinkenbone functionality for use with the PiDP-11 front
panel replica.

The goal is to make installing, upgrading and maintaining a Rapsberry Pi based
PiDP-11 system easy and clean.

If you wish to simply install the packages on your system, see the
[Installation Instructions](../../wiki/Installation-Instructions).

The following packages are provided:

| package               | description                                                |
| --------------------- | ---------------------------------------------------------- |
| simh                  | unofficial variant of simh with blinkenbone features added |
| blinkenlightd-pidp11  | led controller server from the blinkenbone project         |

## simh

https://github.com/desaster/simh-realcons-pdp11

The BlinkenBone project provides a customized SIMH with the necessary changes
for it to interact with the blinkenlightd server. These debian packages use my
own version of it, where the pdp11 related changes have been merged to the
latest simh sources.

## blinkenlightd

https://github.com/j-hoppe/BlinkenBone/

The BlinkenBone project provides servers for various panels and systems.
However, the packages provided here are limited to only PiDP-11 based system.
That means only the pidp11 variant of the blinkenlightd is included, and the
package name is named accordingly.

## pidp11

To make PiDP-11 installation as easy as possible, this package provides a
systemd service that can be used to bring up a simh instance on startup.

## Notes on the debian packages

The script provided in this repository is highly automated. The generated
debian packages are most definitely NOT suitable for release in the official
debian (or raspbian) distributions.
