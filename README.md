# Dynamic View

## Overview
Dynamic View is a World of Warcraft addon created by Erloys that automatically changes the camera view when entering or leaving combat. This addon provides players with the convenience of having different camera perspectives tailored for combat and non-combat situations. It's particularly useful when paired with the [ShaguController](https://shagu.org/ShaguController) Addon for a controller UI.

## Features
- Automatically switches between different camera views based on triggers:

### Normal View
- **Enter Condition**: N/A (Default view)
- **Exit Condition**: N/A
- **Exit View**: N/A

### Combat View
- **Enter Condition**: Entering combat.
- **Exit Condition**: Leaving combat.
- **Exit View**: Normal view (unless Normal trigger is disabled), unless indoors, then it switches to Indoor view (unless Indoor trigger is disabled).

### Indoor View
- **Enter Condition**: Entering an indoor area.
- **Exit Condition**: Leaving the indoor area.
- **Exit View**: Normal view (unless Normal trigger is disabled).

### Melee View
- **Enter Condition**: Performing a melee attack.
- **Exit Condition**: Ceasing melee attacks.
- **Exit View**: Combat view (unless Combat trigger is disabled).

## Installation
1. Extract the contents of the downloaded ZIP file into your World of Warcraft `Interface\AddOns` directory.
2. Restart World of Warcraft if it was running during the installation process.

## Usage
By default, the addon disables all triggers. For each new character, you'll need to activate the desired triggers one by one.

For example, to activate the combat trigger:
- `/dynview enable combat`

To configure a point of view for a trigger, simply position the camera in the desired viewpoint and then use the command:
- `/dynview set combat`


