# The MARS respawn and reinsert system

The MARS system aims at giving players the freedom to manage their respawn and reinsert autonomously, without requiring any zeus intervention.
It is provided as a ready-to-use composition tailored to our unit structure [here](https://steamcommunity.com/sharedfiles/filedetails/?id=2833878594).
Just place it down and you're good!

## Introduction

<details>

The MARS system provides two specific features : a mobile respawn point, and two mobile reinsertion points (one for each squad).
Each SL, ASL and TL is able to move the common respawn point and the squad-specific reinsert point, via the ACE self-interaction menu, under the `Team management` category.
  
  - When they die, players should respawn on the mobile respawn point (which is identified as such on the respawn screen)
  - Upon doing so, they'll find themselves in front of two objects : a crate and a aerial (by default)
  - The crate will provide the player with all he needs to get his loadout (by default, via the unit's quartermaster system)
  - Once geared up, the player will have to ACE interact on the aerial to select the reinsertion point he wants to be teleported to
  - By default, there are two such reinsertion positions, one for each squad
  - When selecting a reinsertion position, the player's screen will fade to black, he will be teleported near to a tent and his screen will fade back in.
  
The most commonly used feature is the mobile reinsert point, which SLs, ASLs or TLs regularly move as the operation unfolds.
When the reinsertion point is moved, all squad members receive a notification.
However, the reinsertion point's location is not marked on the map, it is up to the SL to keep his players updated as to this, so they know where to head once reinserted.
SLs should be careful about where they move their reinsertion position, as moving it too close to an engagement or in an exposed location might result in spawn kills.
<br><br>
The mobile respawn point is a less frequently used feature.
The common mobile respawn point can be moved by both squads' staff; communication on this point is thus particularly important.
Moving this respawn point will move the respawn location, the crate players use to resupply and the aerial which they use to select their reinsert location.
In order to avoid any Arma issues, it is best to avoid moving the respawn point in a tight space or cluttered area.
It is also very important to move it cautiously, considering the tactical environment, ie making sure playters respawning there will not get spawn killed.
The mobile respawn point is designed to be used a a fallback position, if and when necessary.
For instance, if SLs are expecting one of their reinsertion points to be overrun during an operation, moving the respawn point in a secure fallback position would allow players not to walk across the entire AO to get back to the front lines.

</details>
  
## Scripts (for advanced users)

<details>
  
This section presents the required scripts that make up the MARS system, and how you can use them to build your custom layout.<br>

### Teleporter

<details>
 
The following goes into the aerial players use to select their reinsert point (object's variable name `aerial`).

```
[ 
 this, 
 [["MARS_insertMarker_1", "Insert at Fox Red"  ], 
  ["MARS_insertMarker_2", "Insert at Centurion"]] 
] spawn 
{ 
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
 
     [_caller, _marker, _name] spawn 
        { 
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
        }; 
    }, 
    {true}, 
    {}, 
    [_x, _y] 
   ] call ace_interact_menu_fnc_createAction; 
 
   [_insertionPointSelector, 0, ["ACE_MainActions"], _insertAction] call ace_interact_menu_fnc_addActionToObject; 
 
  } forEach _hashMap; 
};  
```

</details>
 
### Resupply

<details>
 
The following goes into the crate players use to get their loadout (object's variable name `crate`).

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
this addAction ["BI Arsenal", {["Open", [true]] call BIS_fnc_arsenal;}];
this addAction ["ACE Arsenal", {[_this select 0, player, true] call ace_arsenal_fnc_openBox}, [this]];
```

</details>

### Moving the respawn and reinsertion points

<details>
 
The following goes into the init section of the players who should be able to move the respawn and reinsertion points (typically SLs, ASLs and TLs).<br>
`<MARS_insertPoint>` is the variable name of the object that acts as a visual cue for the reinsertion location (typically a small tent).<br>
`<MARS_insertMarker>` is the variable name of the marker that represents the exact location where players will be teleported.<br>
When creating your own version of a MARS system, make sure to place and name those two objects accordingly, one pair for each reinsertion position.


```
[this, <MARS_insertPoint>, "<MARS_insertMarker>", aerial, crate, respawn] spawn 
{ 
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
};
```

</details>
  
</details>
  
 ## Note to missionmakers
  
 While it possible to replace the default crate, aerial and tent that represent the various interaction points of the system, it is recommended to do so with caution.
 The script was written with those default, small-size objects in mind, so replacing them with larger objects might result in players getting arma'ed when moving the respawn or reinsertion point!
  
