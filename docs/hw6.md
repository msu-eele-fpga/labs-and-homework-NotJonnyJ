# Homework 6 Asynchronous Conditioner

## Overview
In this homework assignment i created a asychronous contioner for a push button. It takes a messy/jittery button input and creates a one clock cycle output signal that only triggers onece on each button press. The system instantiates a sychronizer, a debouncer, and a one pulse components that are all in respected folders.

## Deliverables
This is the output of my async-conditioner when the jittery button is an input.
![Conditioner_output_wave](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_async_conditioner_wave.png)
![Conditioner_output_text](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_async_condtioner_success.png)

This is the testbech output of the debouncer.
![Debouncer_output_wave](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_deboucer_waveform.png)
![Debouncer_output_text](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_deboncer_success.png)

This is the testbech output of the one-pulse component.
![One_pulse_output_wave](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_one_pulse_wave.png)
![One_pulse_output_text](https://github.com/msu-eele-fpga/labs-and-homework-NotJonnyJ/blob/hw-6/docs/assets/hw6_one_pulse_success.png)


