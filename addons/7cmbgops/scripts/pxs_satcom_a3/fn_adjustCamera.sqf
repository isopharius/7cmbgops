params ["_type"];

// PP effects
	if (_type isEqualTo 1) then
	{
		ppEffectDestroy PXS_ppGrain;
	};

	if (_type isEqualTo 2) then
	{
		PXS_ppGrain = ppEffectCreate ["filmGrain",2005];
		PXS_ppGrain ppEffectEnable true;
		PXS_ppGrain ppEffectAdjust [0.02,1,1,0,1];
		PXS_ppGrain ppEffectCommit 0;
	};

// FLIR setting
call {
	if (_type isEqualTo 3) exitWith {
		true setCamUseTi 7;
		_text = "CMODE T-FLIR";
	};
	if (_type isEqualTo 4) exitWith {
		true setCamUseTi 0;
		_text = "CMODE W-FLIR";
	};
	if (_type isEqualTo 5) then  {
		true setCamUseTi 1;
		_text = "CMODE B-FLIR";
	} else {
		false setCamUseTi 0;
		false setCamUseTi 1;
		_text = "CMODE NORMAL";
	};
};

ctrlSetText [1005,_text];