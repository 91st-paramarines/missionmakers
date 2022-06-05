# Code snippets

Here you will find various code snippets for use in the editor or in zeus, that perform a reasonably specific task.

## ACRE2 and radios

<details>
 
### Adding a radio rack to a vehicle
The following will add an AN/PRC-77 to the vehicle is it called on.
The radio will be accessible by the vehicle's driver and commander.

Editor version (execute in the vehicle's init): 
```
	[
		this,
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
  
Zeus version (execute globally on the vehicle's property window) : 
```
if (isServer) then  
{
	[
		this,
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
};
```
  
</details>
