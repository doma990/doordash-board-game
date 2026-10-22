# Gameplay guide

[Back to the project](../README.md)

### Setup and objective

Choose **Scarer** or **Laugher** from the main menu. A character of your chosen role is assigned randomly, and your opponent receives a character of the opposite role. Both begin at **cell 0**, while the remaining six monsters are stationed around the board.

The floor is a **10 x 10 zigzag grid** numbered 0-99. Moving beyond its end wraps around to the beginning. To win, finish a turn **exactly at cell 99** with **at least 1,000 energy** in your canister; reaching the final cell without enough energy does not end the game.

### A turn on the floor

1. Optionally activate your monster's power-up before moving. Manual activation requires and spends **500 energy**.
2. Press **Roll Dice**. Your monster type can modify the distance rolled.
3. Resolve the destination cell's effect, which can change positions, energy, or status.
4. If the final destination is occupied by your opponent, the move is rejected and you must roll again.
5. The interface updates the board, character cards, dice result, last drawn card, and action log, then passes the turn to the other player.

### Board cells

| Cell | Count | Effect |
| --- | ---: | --- |
| Doors | 50 | Alternating Scarer/Laugher doors on odd-numbered cells. Matching-role landings gain energy; mismatches lose it. Effects also reach the landing monster's same-role stationed teammates. Used doors become exhausted, except when a shield blocks a mismatching-door penalty. |
| Monster cells | 6 | An ally triggers the landing monster's power-up for free. An opposite-role encounter can exchange energies if the landing monster has more energy than the stationed monster. |
| Conveyor belts | 5 | Move forward by the belt's specified distance. |
| Contamination socks | 5 | Move backward and apply a 100-energy penalty before character modifiers; a shield can block the energy loss, but not the movement. |
| Card cells | 10 | Draw and immediately resolve a card from a shuffled pile. The pile is replenished and reshuffled when empty. |
| Normal cells | 24 | No special landing effect. |

Arriving through a transport or a card movement does not trigger another destination-cell effect.

### Monster types

| Type | Passive behavior | Power-up |
| --- | --- | --- |
| **Dasher** | Moves at twice the rolled distance. | **Momentum Rush:** triple movement for the next three moves instead of the usual double movement. |
| **Dynamo** | Doubles energy gains and losses. | **Energy Freeze:** the opponent skips their next turn. |
| **MultiTasker** | Moves half the rolled distance and applies a +200 modifier to energy updates. | **Focus Mode:** normal movement for the next two moves. |
| **Schemer** | Applies a +10 modifier to energy updates. | **Chain Attack:** steals up to 10 energy from each other monster, including stationed monsters, without shield protection. |

The eight available characters are James P. Sullivan, Mike Wazowski, Randall Boggs, Celia Mae, Roz, Fungus, Henry J. Waternoose, and Yeti. Their roles, starting energy, and descriptions are defined in `monsters.csv`.

### Action cards

| Family | Cards bundled in this version | Effect |
| --- | --- | --- |
| Swapper | Position Swap x4 | Swap positions with the opponent when behind. |
| Energy Steal | Small Snatcher x3; Sneaky Thief x2 | Steal 50 or 100 energy, subject to character and shield effects. |
| Start Over | Contamination Code x2; 2319 Alert x3 | Send the current player or their opponent back to the start. |
| Shield | Super Shield x5 | Protect against the next applicable negative energy effect. Only one competitor can hold the shield at a time. |
| Confusion | Mind Scramble x3; Total Confusion x2 | Exchange both competitors' roles for two or three turns. |

**Course-description difference:** the supplied design document specifies a 25-card pile, including one **Mega Drain** card that steals 150 energy. The final local `cards.csv` contains **24 cards** and omits Mega Drain. This repository preserves that final project data; the table above describes what actually ships.

The in-game **Instructions** button explains the turn sequence and winning conditions. The menu includes a music mute control.

This is a local, turn-based game on one computer; no server or online account is required. The original course submission also includes the `W` and `E` debugging shortcuts for moving the active character to cell 99 and adding 500 energy.
