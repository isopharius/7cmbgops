if (dtaDisallowMapclick) exitWith {hint "Mapclick option disabled"};

closeDialog 0;
artilleryclick = addMissionEventHandler [
	"MapSingleClick",
	{
		[_pos,_shift,_alt] execVM "\7cmbgops\scripts\Artillery\Dialog\InputAimpointMapclickProcess.sqf";
        removeMissionEventHandler ["MapSingleClick", artilleryclick];
	}
];
sleep 0.1;
openMap true;