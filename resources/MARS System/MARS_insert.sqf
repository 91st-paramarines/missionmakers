params ["_unit", "_marker", "_name"];

MARS_fnc_Insert =
{
  params ["_marker", "_name"];

  _markerPos    = getMarkerPos _marker;
  _confirmation =
  [
    "Are you sure you would like to insert at this forward point? <br/><br/><t size='3.5'>" + _name + "</t>",
    "Forward Point Insertion",
    true,
    true
  ] call BIS_fnc_guiMessage;

  if (!_confirmation) exitWith {};

  [0, "BLACK", 5, 0] spawn BIS_fnc_fadeEffect;

  disableUserInput true;

  sleep 5;

  player setPosATL [_markerPos select 0, _markerPos select 1, 0];

  disableUserInput false;
  
  [1, "BLACK", 0, 0] spawn BIS_fnc_fadeEffect;
};

[_marker, _name] remoteExec ["MARS_fnc_Insert", _unit];
