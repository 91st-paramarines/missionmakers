# Code snippets

Here you will find various code snippets for use in the editor or in zeus, that perform a reasonably specific task.

## ACRE2 and radios

<details>
 
### Adding a radio rack to a vehicle
The following will add an AN/PRC-77 to the vehicle is it called on.
The radio will be accessible by the vehicle's driver and commander.  
  
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
  
For use in the editor, place this code in the vehicle's init field.  
	For use in zeus, execute this code globally, replacing <b><em>this</em></b> with <b><em>_this</em></b>.

</details>
