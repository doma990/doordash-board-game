# DooRDasH

**Scare vs Laugh Touchdown** — a turn-based JavaFX board game inspired by *Monsters, Inc.*, developed for CSEN 401 at the German University in Cairo.

The project brings together three levels of software design: **an object-oriented class model, a tested game engine, and an interactive JavaFX interface**.

**Java · OOP · JavaFX · JUnit 4**

## 1. Classes and hierarchies

The game models monsters, cards, and board cells as separate class families. Shared state and behavior live in their base classes, while subclasses define the differences between each type.

| Class family | Specialized classes | Responsibility |
| --- | --- | --- |
| [`Monster`](src/game/engine/monsters/Monster.java) | `Dasher`, `Dynamo`, `MultiTasker`, `Schemer` | Character state, movement, energy, and power-up behavior. |
| [`Card`](src/game/engine/cards/Card.java) | `SwapperCard`, `EnergyStealCard`, `StartOverCard`, `ShieldCard`, `ConfusionCard` | Different actions through the shared `performAction` method. |
| [`Cell`](src/game/engine/cells/Cell.java) | `DoorCell`, `MonsterCell`, `CardCell`, and transport cells | Different landing effects through the shared `onLand` method. |

`Monster` and `Card` are abstract classes. `TransportCell` further specializes into `ConveyorBelt` and `ContaminationSock`, while the `CanisterModifier` interface defines a shared contract for energy-changing effects.

This structure uses **inheritance, abstraction, and polymorphism** to represent the game's rules. For example, `Board` can call `onLand` on a cell without implementing each cell's effect itself.

## 2. Solid code and game logic

The class model is connected through a game engine with distinct responsibilities:

- **`Game`** manages player setup, turns, power-up activation, and winning conditions.
- **`Board`** handles the grid, movement, card pile, and cell interactions.
- **`DataLoader`** reads character, card, and cell definitions from CSV files.
- **Custom exceptions** represent invalid moves, insufficient energy, and malformed input data.

Private fields encapsulate character and card state, while overridden methods implement different monster and card behaviors. The engine has no JavaFX dependency, so its rules can be tested separately from the interface.

**165 JUnit tests** check the model and engine, including movement, energy changes, card effects, and invalid actions. Automated builds run on Windows, macOS, and Linux.

## 3. JavaFX GUI

The interface turns the game state into a playable desktop experience:

- A main menu for choosing **Scarer** or **Laugher**, with instructions and music controls.
- A 10 × 10 board with character images, doors, hazards, and transport connections.
- Animated movement, character information panels, and energy indicators.
- Dice and power-up controls, a turn indicator, a last-card display, and an action log.
- A victory screen showing the outcome.

[`GameView`](src/game/view/GameView.java) builds the layouts and visual effects. [`GameController`](src/game/controller/GameController.java) handles player input, calls the engine, and updates the interface.

![DooRDasH gameplay](docs/gameplay.png)

## Gameplay

Two players compete across a 100-cell board, collecting energy and using abilities and cards. Win by reaching **cell 99 — Boo's Door — with at least 1,000 energy**.

[Read the full gameplay guide →](docs/GAMEPLAY.md)

## How to run

Install [JDK 21](https://adoptium.net/temurin/releases/?version=21), then download and extract this repository using **Code → Download ZIP**. Open a terminal in the extracted folder containing `pom.xml`.

**Windows**

```powershell
.\mvnw.cmd javafx:run
```

**macOS / Linux**

```sh
sh ./mvnw javafx:run
```

The included Maven Wrapper downloads Maven and JavaFX automatically on the first run. If Java is not detected, set `JAVA_HOME` to your JDK installation folder. Keep the three CSV files in the project root; they contain the game data.

<details>
<summary>Running the tests</summary>

Use `.\mvnw.cmd clean verify` on Windows or `sh ./mvnw clean verify` on macOS/Linux.

</details>

## Credits

An educational project inspired by *Monsters, Inc.* Characters, imagery, and music belong to their respective owners.

