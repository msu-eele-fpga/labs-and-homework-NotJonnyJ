# Lab 11: Platform Device Driver

## Project Overview
In this lab, I created a device driver for the LED patterns component. The device
driver is built from scratch, built up bit-by-bit to learn about each and every piece along the way.

### Functional Requirements
In the end I am able to achieve all three requiremnts:
1. Demonstrate modified miscdev test program. Show that the program implements the same
custom LED pattern that my hardware state machine in lab 4.
2. Manually control LED patterns component from the command line by writing to the sysfs at-
tribute files.
3. Write a bash script that demonstrates an LED pattern in software-control mode and changing the
base period in hardware-control mode.


## Questions
1. What is the purpose of the platform bus?
> A platform bus is used to interact with hardware that is not discoverable to a computer. The computer need to be
informed about these devices and their characteristics before it can use them.

2. Why is the device driver’s compatible property important?
>It is important because if the two devices dont match then they will not connect resulting 
in a no connection and there will be not binding an we will all be sad.

3. What is the probe function’s purpose?
>The probe finction is what binds the driver to the device.

4. How does your driver know what memory addresses are associated with your device?
>We assigned them by hand to match the custom component we made to interact with the FPGAs registers.

5. What are the two ways we can write to our device’s registers? In other words, what subsystems do we use to write to our registers?
>We can use sysfs to write to these registers and manually enter values to memory or we can write a bash script that can make these commands for us and we just run and executable file.

6. What is the purpose of our struct led_patterns_dev state container?
>The state container stores the pointers to the memory mapped registers.



