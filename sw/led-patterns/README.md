# led-patterns.c Support Document

## Overview
led-patterns.c is a C program that is used to interacts with the memory of the DE10-nano board and is made specifically to change the led pattern running on the device and at what speed it runs at. The program is typically compiled for the ARM  cpu on board.

## Building 
To compile this program it must be compiled in for the FPGA using arm gcc. use the following compile:
```
arm-linux-gnueabihf-gcc -o led-patterns -Wall -static led-patterns.c
```


## Usage
To run this program on the FPGA over putty the following command will get you to the help page.
```
./led-patterns -h
```

To run a new pattern that will run until Ctrl-C is pushed:
```
./led-patterns -p 0x00 1000 0xFF 1000
```

To run this and print the outputs to terminal with the verbose flag
```
./led-patterns -v -p 0x00 1000 0xFF 1000
```

To run a file that describes a pattern:
```
./led-patterns -f pattern2.txt
```
(See pattern1.txt for example)

