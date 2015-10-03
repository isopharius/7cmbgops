if (("sfp_map_editor" callExtension "version") != "") then {
	_world = worldName;
	"sfp_map_editor" callExtension (format ["openWrite;sfp_map_editor_save_%1.txt", toLower(worldName)]);
	_curator = allCurators select 0;

	{
		if !((typeOf _x) in Ares_EditableObjectBlacklist || _x == player || isPlayer _x || _x distance (getmarkerpos "respawn_west") > 500) then {
			_className = typeOf _x;
			_pos = getPosATL _x;
			_vectorDir = vectorDir _x;
			_vectorUp = vectorUp _x;

			_output = format ["'%1', %2, %3, %4", _className, _pos, _vectorDir, _vectorUp];
			"sfp_map_editor" callExtension (format ["write;%1", _output]);
		};
	} forEach curatorEditableObjects _curator;

	"sfp_map_editor" callExtension ("close");
	["Objects saved", "hint"] call BIS_fnc_MP;
} else {
	["Server needs the sfp_map_editor.dll for the save feature", "hint"] call BIS_fnc_MP;
};

true;
