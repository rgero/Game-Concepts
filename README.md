
This is going to be a repo consisting of several projects, likely in Unity and Godot, that exhibit a game concept that I want to play around with implementing. The goal of the smaller projects is to come up with solutions. Because of this, they might not be the most elegant or optimized solutions. This will be particularly true for Godot since that's the engine I'm currently learning.

<!-- omit in toc -->
## Table of Contents
- [Completed Projects](#completed-projects)
  - [Project 01 - Player Detection](#project-01---player-detection)
  - [Project 02 - Enemy Information System](#project-02---enemy-information-system)
- [Potential Projects](#potential-projects)
  - [Enemy Chasing the player](#enemy-chasing-the-player)
  - [Rudamentary Traffic System](#rudamentary-traffic-system)
  - [Fog of War](#fog-of-war)

## Completed Projects
### Project 01 - Player Detection
**Engine** - Godot 4
**Exercise** - I wanted to make a simple scene where an enemy game object could detect the player and would react only if it was able to see them.
**Directory** - `enemy-aggro-and-vision`

### Project 02 - Enemy Information System
Multiple Enemies, when one spots the player they inform the others. This could also be done with a Camera
**Engine** - Godot 4
**Directory** - `enemy-alerting-others`

## Potential Projects
### Enemy Chasing the player
This was something I attempted to do for a GameDev Game Jam

**Required Knowledge** - The NavMesh stuff in Godot

### Rudamentary Traffic System
Multiple cars driving around a grid, and they respect a series of traffic rules (stop signs, simple right of way, they choose random destinations)

**Required Knowledge** - The NavMesh stuff in Godot

### Fog of War
The mechanic known in all RTS games. It sounds like it could be a fun thing to do in GoDot.
