# dual80-for-c128
Extended screens demo with 80 columns total across both screens

THe regular 40-column screen (VIC-II) is on the right, and normally 80-column screen (VDC) is on the left, but reconfigured to 40 columns and IRQ copies what KERNAL stores there to the VIC-II screen in 5 line increments every 1/60 second when VDC not busy, so at most 12FPS

Instructions: be sure to press 80 column button down and boot your C128/C128D with disk in drive

![gif](c128_extended_screen.gif)

Download: [D64 disk image](https://github.com/davervw/dual80-for-c128/raw/refs/heads/main/80dual.d64)
