#!/bin/bash
set -ex

# copy the IHEX to screen's named register "p"
screen -X readreg p $PWD/a.out

# send an <ESC> character to reset to *
screen -X stuff $'\033' # <Escape>
sleep 3
# paste named register "p" into the screen's STDIN
screen -X paste p

# wait for Small Computer Monitor v1.0 (SCM) to respond "Ready"
sleep 10 # TODO

# type 'g 8000'
screen -X stuff $'g 8000'
sleep 1
screen -X stuff $'\015' # <CR>
