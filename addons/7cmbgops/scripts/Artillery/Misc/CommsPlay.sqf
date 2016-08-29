// Arty comms

params ["_asset", "_messageCode", "_audio"];

if NOT(local player) then {};
_side = (side (leader _asset));
if NOT(_side isEqualTo (side player)) exitWith {};

_haveRadio = false;

// Check if the player has a radio
_haveRadio = [] call dta_fnc_HasRadio;
if NOT(_haveRadio) exitWith {};

// Which set of audio files should be used?
_audioSet = "";

_soundFile = "dtaBeep";
if (_side == West) then {_audioSet = dtaAudioBLUFOR};
if (_side == East) then {_audioSet = dtaAudioREDFOR};
if (_side == Resistance) then {_audioSet = dtaAudioINDEP};

if (_audioSet isEqualTo "US") then {
	if (_audio isEqualTo "AdjustFire") then {_soundFile = "dtaAdjustFireUS"};
	if (_audio isEqualTo "MTO") then {_soundFile = "dtaMTOUS"};
	if (_audio isEqualTo "Shot") then {_soundFile = "dtaShotUS"};
	if (_audio isEqualTo "Splash") then {_soundFile = "dtaSplashUS"};
//	if (_audio isEqualTo "RoundsComplete") then {_soundFile = "dtaRoundsCompleteUS"};
	if (_audio isEqualTo"EndOfMission") then {_soundFile = "dtaEndOfMissionUS"};
};

if (_audioSet isEqualTo "PER") then {
	if (_audio isEqualTo "Affirmative") then {_soundFile = "dtaAffirmativePER"};
	if (_audio isEqualTo "Negative") then {_soundFile = "dtaNegativePER"};
	if (_audio isEqualTo "FireMissionReady") then {_soundFile = "dtaFireMissionReadyPER"};
	if (_audio isEqualTo "AdjustFire") then {_soundFile = "dtaAdjustFirePER"};
	if (_audio isEqualTo "MTO") then {_soundFile = "dtaMTOPER"};
	if (_audio isEqualTo "Shot") then {_soundFile = "dtaShotPER"};
	if (_audio isEqualTo "Splash") then {_soundFile = "dtaSplashPER"};
//	if (_audio isEqualTo "RoundsComplete") then {_soundFile = "dtaRoundsCompletePER"};
	if (_audio isEqualTo "EndOfMission") then {_soundFile = "dtaEndOfMissionPER"};
};

if (_audioSet isEqualTo "GRE") then {
	if (_audio isEqualTo "Affirmative") then {_soundFile = "dtaAffirmativeGRE"};
	if (_audio isEqualTo "Negative") then {_soundFile = "dtaNegativeGRE"};
	if (_audio isEqualTo "FireMissionReady") then {_soundFile = "dtaFireMissionReadyGRE"};
	if (_audio isEqualTo "AdjustFire") then {_soundFile = "dtaAdjustFireGRE"};
	if (_audio isEqualTo "MTO") then {_soundFile = "dtaMTOGRE"};
	if (_audio isEqualTo "Shot") then {_soundFile = "dtaShotGRE"};
	if (_audio isEqualTo "Splash") then {_soundFile = "dtaSplashGRE"};
//	if (_audio isEqualTo "RoundsComplete") then {_soundFile = "dtaRoundsCompleteGRE"};
	//if (_audio isEqualTo "EndOfMission") then {_soundFile = "dtaEndOfMissionGRE"};
	if (_audio isEqualTo "RoundsComplete") then {_soundFile = "dtaEndOfMissionGRE"};
};

(leader _asset) sideChat format ["%1",_messageCode];
if (dtaScriptMode) exitWith {};
playSound _soundFile;