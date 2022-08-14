# Code snippets

Here you will find various code snippets for use in the editor or in zeus, that perform a reasonably specific task.

## ACRE2 and radios

<details>
 
### Adding a radio rack to a vehicle
The following will add an AN/PRC-77 to <b>var</b>.
The radio will be accessible by <b>var</b>'s driver and commander.  
This script will NOT work in an `init` field, it is has to called dynamically during the mission (trigger, `execVM`, `spawn`...).
  
```
[
	var,
	[
		"ACRE_VRC64",
		"Dashboard",
		"Dash",
		false,
		["driver", "commander"],
		[],
		"ACRE_PRC77",
		[],
		["intercom_1"]
	],
	false,
	{}
] call acre_api_fnc_addRackToVehicle;
```

</details>

## Carrying and dragging

<details>

The following will respectively make <b>var</b> carriable and draggable through the ACE interaction menu.

```
[var, true, [0, 1, 1], 0] call ace_dragging_fnc_setCarryable;
```  

```
[var, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
```

</details>

## Invulnerability

<details>

The following will make <b>var</b> invulnerable to most damage sources (some minor damage may still occur in the event of a vehicle crash).

```
call {[var, "blockDamage", null, true] call ace_common_fnc_statusEffect_set;};
```

</details>


## Delete vehicle and crew

<details>

Place in way point activation or in a trigger

```
_vehicle= vehicle this;
{ 
  _vehicle deleteVehicleCrew _x; 
} forEach crew _vehicle; 
deleteVehicle _vehicle; 
```
</details>

## Garbage collection and stop respawn on start

Place in description.ext

<details>
	
```
respawnOnStart = -1; 

corpseManagerMode = 3;
corpseLimit = 1;
corpseRemovalMinTime = 60;
corpseRemovalMaxTime = 300;
```
</details>

## Arsenals and loadouts

<details>
Add ACE Arsenal to object :
	
```
// Access via ACE interaction menu
[this, true] call ace_arsenal_fnc_initBox;

// Access via action menu
this addAction ["ACE Arsenal", {[_this select 0, player, true] call ace_arsenal_fnc_openBox}, [this]]; 
```
  
Add BI Arsenal to object :
	
```
// Access via action menu
this addAction ["BI Arsenal", {["Open", [true]] call BIS_fnc_arsenal;}]; 
```
	
Add quick loadout action to object (requires player to have saved a loadout with the quartermaster composition) : 
```
this addAction
[
	"Get loadout",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _savedLoadout = profileNamespace getVariable "NFST_loadout";
		if (isNil "_savedLoadout") then
		{
			hint "No saved loadout.";
		}
		else
		{
			_caller setUnitLoadout _savedLoadout;
			hint "Applied loadout."
		};
	}
];
```
	
</details>

## Reliable music trigger script MP

<details>
	
Define music as follows in description.ext :

```
class CfgMusic
{
	tracks[] = {};
	class YOUR_CLASS_NAME
	{
		name	= "YOUR_DISPLAY NAME";
		sound[]	= { "YOUR_FILENAME_WITH_FILE_EXTENSION", db + 0, 1.0 };
	};
};
```

Play the music track with : 
	
```
if (isServer) then {YOUR_CLASS_NAME remoteExec ["playMusic"];}
```
</details>

## Intro text

<details>
trigger 1
Put this in activation

```
execVM "text1.sqf"; 
```
```
["<t color='#ffffff' size = '4'>Exercise Ajax<br /><br />by  Wonko<br /><br /></t>",-1,-1,2,2,0,789] spawn BIS_fnc_dynamicText;
```

Create a file called text1.sqf put the above code in it. The following 2 line in to seperate sqf files with corresponding triggers.

```
["<t color='#c9060d' size = '2'>91st Paramarines<br /><br /><br />Fox Company<br /></t>",-1,-1,2,2,0,789] spawn BIS_fnc_dynamicText;
```
```
["<t color='#ffffff' size = '1'>Deployed to West Germany<br /><br />1980's<br /><br /></t>",-1,-1,2,2,0,789] spawn BIS_fnc_dynamicText;
```	
</details>

## Protection zone

<details>
Put the following in a server trigger's activation :

```	
{
  private _player = _x;
  removeAllWeapons _x; 
  {
    _player removeMagazine _x;
  } forEach magazines _x; 
} forEach allPlayers;
```	
</details>

## Talk action

<details>
	
```	
this addAction 
[ 
  "Talk", 
  {hint "ADD YOUR TEXT HERE";}, 
  nil, 
  0, 
  true, 
  true, 
  "", 
  "(_this distance2D _target < 2)", 
  50, 
  false, 
  "", 
  "" 
];  
```	
	  
</details>

	  
## Explosion on a trigger

<details>
Put the following in a server trigger's activation :
```
bomb = "Bo_GBU12_LGB" createVehicle getMarkerPos "ex";
```
</details>
