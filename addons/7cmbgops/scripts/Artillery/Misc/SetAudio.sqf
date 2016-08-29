// Sets the audio for a side

params ["_playerSide", "_audioSide"];

if (_playerSide == "BLUFOR") then {dtaAudioBLUFOR = _audioSide};
if (_playerSide == "REDFOR") then {dtaAudioREDFOR = _audioSide};
if (_playerSide == "INDEP") then {dtaAudioINDEP = _audioSide};