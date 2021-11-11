# mgh80-experiments
Programming experiments for the [MGH80](https://github.com/Kris-Sekula/mgh80/)

Use `screen /dev/cu.usbserial-* 115200` to begin a GNU `screen` session.

`./assemble.sh` will generate an
[Intel HEX](https://en.wikipedia.org/wiki/Intel_HEX) `a.out`

Then,
`./serial.sh` will

1. send an Escape to the `screen` session
2. paste the IHEX to the `screen` session
3. execute `g 8000` in
[Small Computer Monitor](https://smallcomputercentral.wordpress.com/small-computer-monitor/small-computer-monitor-v1-0/)
to begin execution.
