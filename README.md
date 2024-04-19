# Dynamic View

## Overview
Dynamic View is a World of Warcraft addon created by Erloys that automatically changes the camera view when entering or leaving combat. This addon provides players with the convenience of having different camera perspectives tailored for combat and non-combat situations.
I personally use it with the [ShaguController](https://shagu.org/ShaguController) Addon. for my controller ui.

## Features
- Automatically switches between two pre-defined camera views:
  - Normal View: Default camera perspective for non-combat situations.
  - Combat View: Camera perspective optimized for combat scenarios.
- Ability to customize camera views by editing the Lua file.
- Persistent saved view settings between gaming sessions.
- Optional logging functionality for debugging purposes.

## Installation
1. Extract the contents of the downloaded ZIP file into your World of Warcraft `Interface\AddOns` directory.
2. Restart World of Warcraft if it was running during the installation process.

## Usage
Once installed, Dynamic View will automatically manage your camera perspective based on your combat status. There are no additional configuration options in the game interface. However, you can customize the camera views by editing the `DynView.lua` file located in the addon's folder.

To save a specific camera view, you can bind a key to the `setview (number)` keybind in the game's key bindings menu. The saved view will persist between gaming sessions.

## Configuration
You can customize the camera views by editing the `DynView.lua` file:
- Adjust the `NormalView` and `CombatView` variables to set the desired camera view IDs.
