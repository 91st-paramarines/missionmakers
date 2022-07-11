params ["_insertionPointSelector", "_insertionPointList"];

_hashMap = createHashMapFromArray _insertionPointList;
{
	_insertAction =
	[
		"moveFP",
		_y,
		"",
		{
			params ["_target", "_caller", "_arguments"];
			_arguments params ["_marker", "_name"];

			[_caller, _marker, _name] execVM "MARS_insert.sqf";
		},
		{true},
		{},
		[_x, _y]
	] call ace_interact_menu_fnc_createAction;

	[_insertionPointSelector, 0, ["ACE_MainActions"], _insertAction] call ace_interact_menu_fnc_addActionToObject;

} forEach _hashMap;
