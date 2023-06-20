_In Progress..._
# Ping Pong Game
Spring 2022

VHDL based ping pong game using the peripherals of a DE1-SoC board and manipulating the internal clock frequency to progress the game. 

## Components
### Clock Division
The clock division file is esssential in the components of the game since it utilizes the build in high frequency clock of the DE1-SoC board to create a lower frequency clock to display the change in lights on the board. Without the clock division, the LEDs will move at such a quick pace they will be unidentifiable. 

The logic of this file is that for every 262144 cycles the internal clock makes, a single clock cycle is outputted to the rest of the program. This means that the high and low of the outputted clock is each 131072 cycles.

### Clock Levels
After the internal clock is set to a lower frequency, it goes through another division that insted increases the frequency of the clock in order to create levels in the game. 

### Ping Pong Light Movement

### Top Level Ping Pong Game

## Testing

## Results and Analysis
