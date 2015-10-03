	private "_FSFSV_SacADosGwh";
	_FSFSV_SacADosGwh = player getVariable "FSFSV_BACKPACK";
	detach _FSFSV_SacADosGwh;
	player action ["AddBag",_FSFSV_SacADosGwh,(backpackCargo _FSFSV_SacADosGwh) select 0];
	player setVariable ["FSFSV_BACKPACK",objnull];
	player forceWalk false;