# FPGA_Projects
FPGA Projects from ECEN3002

These are the two major projects created from ECEN3002. Both Projects are designed to run on the DE10 standard board. 
The first project is a VGA controller for a 640x480 display. It generates the specific timing and will draw a square and 
move it across the screen in the X direction. There are also some TCL scripts for setting patterns in memory and 
displaying them.

The second project is a write only I2C driver for the WM8731 Audio Codec. An audio file is instantiated in ROM and then
the necessary timing and I2C commands are generated. The I2C driver is write only because the WM8731 is a write
only device. There is a write up for the project but it is somewhat out of date. At the time of course completion, the 
driver did not function as intended. This was fixed afterwords and the problem turned out to be a simple case of sending
incorrect commands during the configuration sequence.

There are simple testbenches for each project but nothing too extreme, just enough to see timing waveforms. Both projects
were created using the Quartus development suite and Modelsim for the testbenches.
