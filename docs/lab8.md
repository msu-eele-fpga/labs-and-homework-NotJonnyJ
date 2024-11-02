# Lab 8 Creating LED Patterns with a C Program Using /dev/mem in Linux

## Overview
In this lab we will take off our hardware development hat, i.e., our “hard hat,”
and put on our software development hat, i.e., our “soft hat.” We will still use the
/dev/mem file to access physical memory, which requires having root access, but
we write a C program that will generate LED patterns.

## Deliverables
This is a link to the [README.md file](../sw/led-patterns/README.md) for the led-patterns.c file and it describes how to run it.

### Address Calculations
To calculate the physical addresses of your component’s registers i used help from a previous lab in a file called [devmem](../sw/devmem/devmem.c).

From there I was able to create a constant for each register address. The registers begin at address 0xFF200000 through 0xFF200008 in incremants of 4 to account for the width of registers.

When assigning a new pattern to the LEDs requires the program to turn the LEDS into software control mode and then assign the patterns by assigning the address for the LED register. When the pattern has finished or Ctrl-C has been pushed the program will set the FPGA back into hardware control mode and the LED patterns that were running before will continue.


