# Code snippets

Here you will find various code snippets for use in the editor or in zeus, that perform a reasonably specific task.

## ACRE2 and radios

<details>
 
### Adding a radio rack to a vehicle
The following will add an AN/PRC-77 to <b>var</b>.
The radio will be accessible by <b>var</b>'s driver and commander.  
  
```
if (isServer) then  
{
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
};
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

