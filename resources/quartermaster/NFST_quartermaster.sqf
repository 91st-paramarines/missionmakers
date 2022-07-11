NFST_fnc_quartermasterAddDefaultActions =
{
	params ["_target"];

	removeAllActions _target;

	_target addAction
	[
		"Get loadout",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			private _savedLoadout = profileNamespace getVariable "NFST_loadout";
			if (isNil "_savedLoadout") then
			{
				hint "No saved loadout, use 'Save loadout' to do so.";
			}
			else
			{
				_caller setUnitLoadout _savedLoadout;
				hint "Applied loadout."
			};
		},
		nil,
		0,
		true,
		true,
		"",
		"(_this distance2D _target < 3)",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"Save loadout",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
	    private _currentLoadout = getUnitLoadout _caller;
	    profileNamespace setVariable ["NFST_loadout", _currentLoadout];
			hint "Your current loadout is now saved."
		},
		nil,
		-1,
		false,
		true,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"------------------",
		{},
		nil,
		-2,
		false,
		false,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"ACE Arsenal",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
	    [_target, _caller, true] call ace_arsenal_fnc_openBox;
		},
		nil,
		-3,
		false,
		true,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"BI Arsenal",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
	    ["Open", [true]] call BIS_fnc_arsenal;
		},
		nil,
		-4,
		false,
		true,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"-------------------",
		{},
		nil,
		-5,
		false,
		false,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"<t color='#00FF00'>Quick loadouts</t>",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_target call NFST_fnc_quartermasterAddTemplateActions;
		},
		nil,
		-6,
		false,
		false,
		"",
		"true",
		50,
		false,
		"",
		""
	];
};


NFST_fnc_quartermasterAddTemplateActions =
{
	params ["_target"];

	removeAllActions _target;

	_target addAction
	[
		"<t color='#FF0000'>Back</t>",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_target call NFST_fnc_quartermasterAddDefaultActions;
		},
		nil,
		0,
		false,
		false,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	_target addAction
	[
		"-------------------",
		{},
		nil,
		-1,
		false,
		false,
		"",
		"true",
		50,
		false,
		"",
		""
	];

	{
	  if (_x != _this) then
	  {
	    _this addAction
	    [
	    	[configFile >> "CfgVehicles" >> typeOf _x] call BIS_fnc_displayName,
	    	{
	    		params ["_target", "_caller", "_actionId", "_arguments"];

	        _caller setUnitLoadout (_this select 3);
	    	},
	    	getUnitLoadout _x,
	    	-5,
	    	false,
	    	true,
	    	"",
	    	"true",
	    	50,
	    	false,
	    	"",
	    	""
	    ];
	  };
	} forEach units _this;
};

_this call NFST_fnc_quartermasterAddDefaultActions;
