params ["_unit", "_tent", "_marker", "_aerial", "_crate", "_respawn"];

_actionMoveInsert =
[
	"moveInsert",
	"Move insert",
	"",
	{
		params ["_target", "_caller", "_arguments"];
		_arguments params ["_tent", "_marker"];

		_unitPos  = getPosATL _target;
		_unitDir  = getDir _target;
		_distance = 3;

		_targetX = (_unitPos select 0) + (_distance * (sin _unitDir));
		_targetY = (_unitPos select 1) + (_distance * (cos _unitDir));

		_marker setMarkerPos [_unitPos select 0, _unitPos select 1];

		_tent setDir   ([_targetX, _targetY, 0] getDir _target) + 180;
		_tent setPosATL [_targetX, _targetY, 0];

		hint "Insertion point has been moved!";
		["Squad lead has moved your insertion point!"] remoteExec ["systemChat", group _target];
	},
	{true},
	{},
	[_tent, _marker]
] call ace_interact_menu_fnc_createAction;

[_unit, 1, ["ACE_SelfActions", "ACE_TeamManagement"], _actionMoveInsert] call ace_interact_menu_fnc_addActionToObject;


_actionMoveRespawn =
[
	"moveRespawn",
	"Move respawn",
	"",
	{
		params ["_target", "_caller", "_arguments"];
		_arguments params ["_aerial", "_crate", "_respawn"];

		_unitPos  = getPosATL player;
		_unitDir  = getDir player;
		_distance = 3;

		_targetX = (_unitPos select 0) + (_distance * (sin _unitDir));
		_targetY = (_unitPos select 1) + (_distance * (cos _unitDir));

		_aerial  setDir   ([_targetX      , _targetY,       0] getDir _unit) + 180;
		_aerial  setPosATL [_targetX - 0.5, _targetY - 0.5, 0];
		_crate   setDir   ([_targetX      , _targetY      , 0] getDir _unit) + 180;
		_crate   setPosATL [_targetX + 0.5, _targetY + 0.5, 0];
		_respawn setPosATL [_targetX + 2  , _targetY + 2  , 0];

		hint "Respawn point has been moved!";
		["Squad lead has moved your respawn point!"] remoteExec ["systemChat", group _unit];
	},
	{true},
	{},
	[_aerial, _crate, _respawn]
] call ace_interact_menu_fnc_createAction;

[_unit, 1, ["ACE_SelfActions", "ACE_TeamManagement"], _actionMoveRespawn] call ace_interact_menu_fnc_addActionToObject;
