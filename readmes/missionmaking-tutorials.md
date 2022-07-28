# Missionmaking tutorials

## File types

<details>

Arma uses several specific file extensions for their purposes. The only one you **have** to know about to make a multiplayer mission is the .pbo.
The other file formats are reserved for specific purposes, but they are not required to make a fully functional mission.

- **PBO** :  this is the packaged (or binarized, executable, machine-readable...) mission file; it's the one the server will run, so that's what you want to give server admins so they can upload it to the server
- **SQM** :  this is the unpackaged mission file, the one that's updated every time you hit `Ctrl` + `S`, **do not** give server admins this file for uploading, we want the **.pbo**
- **EXT** :  this is an arma mission configuration file, that can be used for elaborate purposes, or merely to define some mission settings concisely
- **SQF** :  this is an arma script file, written in the SQF language, use a text editor to edit it
- **PAA** :  this is an arma texture file; PAAs can be converted from usual image formats using the Arma 3 Tools software or on [Gruppe Adler's website](https://paa.gruppe-adler.de/).
converting a regular image to the .paa format can be frustrating for two reasons
  - the width and height of PAAs must be powers of two (ie 128, 256, 1024...), so the source image they are converted from must as well (this is a hardline requirement, 511 by 512 will not work)
  - the image must not be layered; while this is generally not an issue, if the conversion fails despite dimensions being appropriate, unseen layers defined in more elaborate image formats such as .png may be the problem, so convert your image to .jpg and then convert it to .paa

</details>
  
## Mission folder structure

<details>
  
Unpackaged mission files are stored in a mission folder located in the `missions` or `mpmissions` folder of your arma profile folder.
By default, the mission folder will only contain a `mission.sqm` file, which describes your entire mission.
Additional resources (script files, pictures, sounds, movies, so on) can be placed directly next to the `mission.sqm`, or within nested subfolders if necessary.
They can then be referenced in the Eden Editor by their path relative to the `mission.sqm` file.

Packaged mission file, *ie* the PBOs, are stored in the `Missions` or `MPMissions` folder of your Arma install folder.
As they are already packaged, PBOs contain any files that were present in the mission folder at the time of the packaging, so you don't need to add anything to it.

</details>
  
## description.ext

<details>
  
The `description.ext` is an optional file you can place in your mission root folder.
You can use it to specify various settings in a single file, instead of having to go over multiple editor tabs.
It can also be used for more advanced purposes not covered here, such as adding config classes.
The template provided [here](resources/description.ext) allows you to bypass the `Presentation`, `Overview`, `Overview (Locked)` and `Loading Screen` tabs of the `Attributes`>`General` window of the editor.
Just place it next to your `mission.sqm` file, edit it with the appropriate setttings, save it and you're good. 
Settings specified in the description.ext file override those defined within the editor!
 
</details>
  
## Packaging and sharing your mission file

<details>
  
The mission folder and its contents are unpackaged data that can be modified via the in-game editor.
Those unpackaged files are the ones you'll want to share when collaborating with other missionmakers.
On the other hand, if you want to upload your mission to a server, you have to package it into a PBO first.
To do so, go to `Scenario`>`Export`>`Export to Singleplayer` or `Export to Multiplayer` (this will only change the destination folder of the PBO, both options work for creating a multiplayer mission).
The game will package your mission and its resources, and will produce a .pbo file in the `Missions` or `MPMissions` folder of your arma install folder, depending on the export option you chose.
  
</details>

## Addon settings

<details>
 
### Settings hierarchy
In multiplayer, add-on settings are three-tiered :
- Client settings affect only the local machine.
They are set by each connected player for their own computer.
- Mission settings affect all connected players.
They are set by the missionmaker, and can overwrite client settings **if explicitly specified**.
- Server settings affect all connected players.
They are set by the server admin, and can overwrite mission settings as well as client settings **if explicitly specified**.
 
### Default settings
- [mission.txt](addon-settings/mission.txt) contains the current mission add-on settings for missionmakers to import into their own scenarios.
- [server.txt](addon-settings/server.txt) contains the current server add-on settings (for reference).
  
</details>
