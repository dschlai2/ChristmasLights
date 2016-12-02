# ChristmasLights
Christmas Light Show -- SystemVerilog code for synthesizing to FPGA


Files included:

main_controller.sv -- top level module. Contains the global clock, with easy plug-and-play in placing other songs/modules depending on
songs you want to play

Barney.sv -- Song "I love you" from Barney

Bieber_alaylm.sv -- Song "As long as you love me" from Justin bieber

pattern1.sv -- repeating light patterns. Not synchronized to any specific song, but just has overall designs.

sparkle_on.sv -- lights are almost always on, but lights occasionally "twinkle" / turn off briefly

Trans_Syberian.sv -- Song -- Trans-Siberian Orchestra's "Carrol of the Bells"

wizzards_in_winter.sv -- Song "Wizards in winter" from Trans-Siberian Orchestra

I use Altera DE0 Nano FPGA development board for this project and Quartus for editing/compiling/fitting

To map to FPGA -- must be synthesized and use a pin planner/fitter to hook up I/O pins to relays. clk is designed to be a 50MHz signal
rst_n is active low. May have to flip light signals depending on if your relays are active high or active low.
questions? email me at: schlais2@wisc.edu
