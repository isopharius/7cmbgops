
// whether server is dedicated or the host, return a wind index for the EFX

MKY_arWind = [0,[0,-1]];

// server needs to find a bearing for the wind
_MKY_fnc_getWind = {
	// array of cardinal bearings
	private _arBearing = [45,135,225,315];
	// array of signed integers for wind (in order of bearings array)
	private _arSigns = [[-1,-1],[-1,1],[1,1],[1,-1]];
	// get a wind index value
	private _intWindIndex = floor (random (4));
	// set the global/public bearing variable indices
	MKY_arWind set [0,(_arBearing select _intWindIndex)];
	MKY_arWind set [1,(_arSigns select _intWindIndex)];
	(true);
};

// get wind details
call _MKY_fnc_getWind;
// set wind on server
setWind [((MKY_arWind select 1) select 0) * 6,((MKY_arWind select 1) select 1) * 6,true];

// publicize the variables for clients
publicVariable "MKY_arWind";
sleep 1;
varEnableSand = true;
publicVariable "varEnableSand";
