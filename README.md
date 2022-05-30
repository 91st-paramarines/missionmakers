# Missionmakers resources

This is the place where we gather all sorts of useful stuff for our missionmakers

## Addon-settings

<details>
  
### Settings hierarchy
In multiplayer, add-on settings are three-tiered :
- client settings affect only the local machine. They are set by each connected player for their own computer.
- mission settings affect all connected players. They are set by the missionmaker, and can overwrite client settings <b>if explicitly specified</b>.
- server settings affect all connected players. They are set by the server admin, and can overwrite mission settings as well as client settings <b>if explicitly specified</b>.
 
### Default settings
[This file](mission.txt) contains the current mission add-on settings for missionmakers to import into their own scenarios.<br>
[This file](server.txt) contains the current server add-on settings (for reference).
  
</details>

## Missionmaker's checklist

<details>

This is not a step-by-step guide to making a good mission, more like guidelines to avoid a catastrophe ;).

### General advice

  - check your mods are up to date
- make sure you're using the correct modlist (ie remove whatever additional mods you may be using client-side)
- if you are making a long mission (several main objectives), do a multiplayer test every time you complete a major section, on a dedicated server if available, local host otherwise
- if you don’t have direct access to the server ask either Winters, Compton, Ollo, Wonko or Miller
- we don’t want a server test to be run at 5 PM day of, always try and get a server test done as far in advance as you practically can (two days is a good compromise)
- have you set a particular time for your mission to start in game ?
  
### In-game

- load in the add-on on settings
- if you wish an add-on setting to be changed, bring it up to your CO
- under "Attributes > Settings > General > Misc", tick “Binarise the scenario file & editable objects (zeus)"
- under "Attributes > Settings > General > Multiplayer > Lobby", untick "Enable AI"
- under "Attributes > Settings > General > Multiplayer > Respawn" select "Respawn on custom position" then select "Select respawn position" then set the respawn delay to 5 seconds
  
</details>
