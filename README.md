# DooRDasH

A turn-based JavaFX board game developed for **CSEN 401** at the German University in Cairo. In **DooR DasH: Scare vs Laugh Touchdown**, two monsters compete on the factory floor of Monstropolis: one collects scream energy as a **Scarer**, while the other collects laugh energy as a **Laugher**.

Cross a 100-cell, Snakes-and-Ladders-style board, manage your energy, and use character abilities and action cards to reach **Boo's Door with at least 1,000 energy**. Position alone is not enough to win.

**Java · JavaFX · Object-oriented design · JUnit 4 · Maven**

![DooRDasH gameplay: characters, board, dice controls, and action log](docs/gameplay.png)

## Download and run

1. Install a **JDK 21**, such as [Microsoft OpenJDK](https://learn.microsoft.com/en-us/java/openjdk/download) or [Eclipse Temurin](https://adoptium.net/temurin/releases/?version=21). Set `JAVA_HOME` to the JDK installation directory. A Java 8 runtime alone is not enough for this Maven build.
2. Use **Code → Download ZIP** above and extract the ZIP, or clone this repository:

   ```sh
   git clone https://github.com/doma990/CSEN-401-Project---277.git
   cd CSEN-401-Project---277
   ```

3. Open a terminal in the extracted project folder (the folder containing `pom.xml` and the three CSV files).
4. Start the game:

   **Windows PowerShell**

   ```powershell
   .\run.bat
   ```

   **macOS / Linux**

   ```sh
   sh ./run.sh
   ```

The included Maven Wrapper downloads Maven and the JavaFX dependencies on the first run, so an internet connection is needed initially. You do not need to install Maven, copy JavaFX JARs manually, or use Eclipse. The launch scripts always run from the project root so the CSV data can be found.

You can also run `./mvnw javafx:run` on macOS/Linux or `.\mvnw.cmd javafx:run` on Windows from the root folder. If a ZIP extraction does not preserve executable permissions, use `sh ./mvnw javafx:run`.

## How to play

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

## Project structure

```text
project root/
├── pom.xml                    Maven dependencies and build configuration
├── mvnw, mvnw.cmd             Maven Wrapper for macOS/Linux and Windows
├── .mvn/wrapper/              Wrapper configuration
├── run.bat, run.sh            Start the game from the correct working directory
├── cards.csv                  Action-card definitions
├── cells.csv                  Board-cell definitions
├── monsters.csv               Character definitions
└── src/
    ├── game/
    │   ├── controller/        Application entry point and UI event handling
    │   ├── engine/            Board, turns, characters, cards, cells, and rules
    │   ├── view/              JavaFX menus, board, animations, and dialogs
    │   └── tests/             Original JUnit milestone tests
    └── resources/             Images, icons, and background music
```

The repository root is the complete `DoorDash` project. There is no additional enclosing `DoorDash` folder to navigate into after extraction. All source code, runtime data, and media assets are included. Generated `bin/` and `target/` folders are excluded because they are rebuilt locally.

The original Eclipse project files are retained. For the portable build, import **Existing Maven Projects** and select `pom.xml`, with JDK 21 configured. The original Eclipse metadata references Java 8; let your IDE refresh the project from Maven rather than using that old runtime configuration.

## Design

- **Game engine:** `Game` handles turns and winning conditions, while `Board` manages board initialization and movement.
- **Object-oriented model:** specialized monsters, cards, and cells use inheritance and polymorphism to implement different behaviors. Interfaces define shared effects; custom exceptions represent invalid game actions.
- **Data-driven setup:** `DataLoader` reads character, card, and cell definitions from the three root CSV files.
- **Presentation:** `GameView` creates JavaFX components and animations. `GameController` connects button actions to the engine and updates the displayed state.

## Build and tests

**Windows**

```powershell
.\mvnw.cmd clean verify
```

**macOS / Linux**

```sh
sh ./mvnw clean verify
```

The build compiles the application, copies all 32 media assets, runs the **165 original JUnit tests**, and packages the application classes. Test fixtures are copied into `target/test-data`, because the original tests rewrite CSV files; your playable root data stays untouched.

The generated JAR is not a self-contained desktop installer. Use the launch scripts or `javafx:run`, which supply JavaFX and its platform libraries. A desktop session is required to play.

## Troubleshooting

- **`JAVA_HOME` / `javac` error:** install a full JDK 21 and check `java -version`. `JAVA_HOME` must point to the JDK folder, not its `bin` subfolder.
- **Missing `cards.csv`, `cells.csv`, or `monsters.csv`:** extract the entire repository and use the launch scripts. Do not download only `src`.
- **JavaFX runtime missing:** use the included Maven command instead of running the main class directly without its dependencies.
- **First launch appears slow:** Maven is downloading dependencies. Later launches use its local cache.
- **Linux display or media errors:** JavaFX needs a graphical desktop and native graphics/audio libraries supported by your Linux distribution. This is a desktop application, not a headless service.

## Context and credits

This repository preserves an educational course project. The characters, imagery, and music are inspired by *Monsters, Inc.* and remain the property of their respective owners. The Apache Maven Wrapper scripts retain their original license headers. No ownership of third-party artwork or music is claimed.

