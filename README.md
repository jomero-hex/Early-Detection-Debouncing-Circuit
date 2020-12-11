# Early-Detection-Debouncing-Circuit

## Description

The output timing diagram is shown below. In this lab we will be building the early detection scheme. When the
input changes from 0 to 1, the FSM responds immediately. The FSM then ignores the input for about 20 ms to avoid 
glitches. After this amount of time, the FSM starts to check the input for the falling edge. Follow the FSM design 
procedure to design the early debouncing scheme.

1. Derive the state diagram and ASM chart for the circuit.

2. Derive the HDL code based on the state diagram and/or ASM chart.

3. Derive a testbench and use simulation to verify operation of the code.

4. Show the switch signal and the debounced signal on the oscilloscope.

5. The circuit diagram below is an interesting way to test the denouncer, it counts
the number of rising edges with and without the debouncer, it then shows the count on
the 7-segment display. Build this circuit.

![Diagram](https://github.com/jomero-hex/Early-Detection-Debouncing-Circuit/blob/main/Capture.PNG)
