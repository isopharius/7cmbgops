/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Target Found Script
******************************************************************************************************* */
private "_dmspercent";
params ["_driver"];
//_cbomb = _driver getVariable "Vehicle";
_cbomb = vehicle _driver;
karma_cb_carbomblist = karma_cb_carbomblist - [_cbomb];
karma_cb_wrecklist set [count karma_cb_wrecklist, _cbomb];
karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
_dmspercent = (floor (random 100));
//Marker
if (_dmspercent < 50) then {
	_veh = createVehicle ["HelicopterExploSmall", getPosATL _cbomb, [], 0, "NONE"];
};