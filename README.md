# Ping Pong Game
_Spring 2022_

This is a personal interpretation of an one-player ping pong game using the peripherals of the DE1-SoC board. The aim of the game is for the player to reach the maximum number of levels, or bounce the "ball" from one end to another, while the speed of the "ball" is increasing. A ball is represented by an active LED between the 10 possible LEDs and the levels are displayed as a counter with the seven-segment LEDs.

## Components
### Clock Division
The clock division file is esssential in the components of the game since it utilizes the build in high frequency clock of the DE1-SoC board to create a lower frequency clock to display the change in lights on the board. Without the clock division, the LEDs will move at such a quick pace they will be unidentifiable. 

The logic of this file is that for every 262144 cycles the internal clock makes, a single clock cycle is outputted to the rest of the program. This means that the high and low of the outputted clock is each 131072 cycles. Since the internal clock is 50 MHz, the output of the clock division is about 95 cycles in a secound. 

### Clock Levels
After the internal clock is set to a lower frequency, it goes through another division that insted increases the frequency of the clock in order to create levels in the game. Similar to the clok division file, a counter changes the frequecy of the cycles in an input clock. However, the counter begins with a larger number to produce a "slow moving ball" and increases the speed by decreasing the counter as the levels progress to inversely increase the frequency. 

Originally, the clock division and level files were combined into one meaning that the game program only required the internal clock to be modified once. However, attempts at combining the clock caused the speed of the "ball" to increase exponentially and only allowed up to three levels for the average player. For a better experience, the clock division and level manipulation were separated into two files.

### Ping Pong Light Movement
After the clock was modified and allowed for a slow blink of the LEDs, the LEDs could be programmed to mimic the movement of a ball. This was done by only activating an LED at a time and shifting the active LED by one position. When the last LED is activated, the "ball" will "bounce" and the LEDs will switch and activate one at a time in the opposite direction.

Although a simple premise, there were issues in generating the if statement to recognize the last LED was active in time and would cause the "ball to fall off" and would display no activated LEDs. Therefore, two extra bits on each side would be used to detect when the last LED was active and would "catch" the ball to send it to the other direction. Even though those bits are not connected to any LED on the DE1-SoC board, they would make sure an LED is present at all times. 

To ensure the game was fair an a player did not just simple activate the last two switches indefinatly, there is an additional condition checking for only one switch to be active in order for the ball to "bounce". Otherwise, the game will end.

### Top Level Ping Pong Game
The top level of the game can be seen [here](pingpong.vhd) that combines all the other files into one. There is an additional file, a display file, used to display the "ball" and the current level count. 

The program is connected to the DE1-SoC board using Quartus Prime and the board manual for pin mapping. 

## Testing
Basic program testing was done using modelSim. Folder containing modelSim scripts used can be found [here](modelsim). Proper testing was done by implementing the program completely into Quartus Prime.

Below are screenshots of the modelSim simulations that demonstrate the programs are working with the proper inputs.

This simulation is of the clock level properly reducing the frequency of the clock with the internal counter that waits until it reaches 30. 

![modelSim clock level pt 1](https://github.com/ZafiroParedes/Ping_Pong_Game/assets/91034132/80f5b024-b982-4b76-bfca-b1faf0227027)

![modelSim clock level pt 2](https://github.com/ZafiroParedes/Ping_Pong_Game/assets/91034132/15803794-f0fd-473b-8e22-cd97b8ee5128)


This simulation is of the ping pong light movement that shows an active one in a series of bits that moves from one end to the other properly and properly increases the level after the ball completes two bounces. 

![modelSim ping pong game pt 1](https://github.com/ZafiroParedes/Ping_Pong_Game/assets/91034132/1ddca86e-4b48-4ed4-b4e2-1cd0db0c99fb)
![modelSim ping pong game pt 2](https://github.com/ZafiroParedes/Ping_Pong_Game/assets/91034132/fd506441-4caf-427b-b767-64850bae104f)
![modelSim ping pong game pt 3](https://github.com/ZafiroParedes/Ping_Pong_Game/assets/91034132/8b6ae55b-a71f-455a-931c-cb6bea9f683b)


## Results
Below is a video of the game functioning completely. 

![video of game]()

