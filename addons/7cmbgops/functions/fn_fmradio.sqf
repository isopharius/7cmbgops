_radio = _this;

if (isnil "fmradio") then {
	fmradio = [_radio];
} else {
	if (_radio in fmradio) then {
		_log = (attachedObjects _radio) select 0;
		_grp = group _log;
		detach _log;
		deletevehicle _log;
		deletegroup _grp;
		fmradio = fmradio - [_radio];
	} else {
		fmradio pushback _radio;
	};
};

if (_radio in fmradio) then {
	[_radio] spawn {
		_speech = [
			["speech_ra_1",4],
			["speech_ra_2",6],
			["speech_ra_3",4],
			["speech_ra_4",5],
			["speech_ra_5",9],
			["speech_ra_6",5],
			["apeech_ra_7",20],
			["jingle_ra_1",10],
			["speech_rs_1",4],
			["speech_rs_2",4],
			["speech_rs_3",5],
			["speech_rs_4",7],
			["speech_rs_5",9],
			["speech_rs_6",5],
			["speech_rs_7",17],
			["jingle_rs_1",8]
		];

		_music = [
			["music_ra_1",47],
			["music_ra_2",31],
			["music_ra_3",50],
			["music_ra_4",76],
			["music_ra_5",50],
			["music_ra_6",113],
			["music_ra_7",79],
			["music_ra_8",96],
			["music_ra_9",86],
			["music_ra_10",60],
			["music_ra_11",110],
			["music_rs_1",109],
			["music_rs_2",95],
			["music_rs_3",49],
			["music_rs_4",39],
			["music_rs_5",62],
			["music_rs_6",74],
			["music_rs_7",50],
			["music_rs_8",39],
			["music_rs_9",67],
			["music_rs_10",55],
			["music_rs_11",68],
			["viet_bird",140],
			["viet_bornwild",310],
			["viet_caldreaming",161],
			["viet_caligirls",155],
			["viet_crosstown",139],
			["viet_evedestruction",213],
			["viet_foxeylady",267],
			["viet_goodlovin",50],
			["viet_gottagetout",194],
			["viet_greenriver",156],
			["viet_badmoon",139],
			["viet_fortunateson",140],
			["viet_runthroughjungle",186],
			["viet_hellovietnam",96],
			["viet_heyjoe",202],
			["viet_houserisingsun",271],
			["viet_ontheroad",302],
			["viet_paintitblack",205],
			["viet_purplehaze",171],
			["viet_satisfaction",226],
			["viet_sitdockbay",165],
			["viet_theend",387],
			["viet_theseboots",160],
			["viet_toldnation",72],
			["viet_trackmytears",174],
			["viet_wagner",319],
			["viet_whatsound",104],
			["viet_whiterabbit",152],
			["viet_whitershade",239],
			["viet_whodoyoulove",179],
			["viet_wildthing",464],
			["viet_wipeout",158],
			["viet_wooly",143]
		];

		params ["_radio"];
		_grp = createGroup west;
		_log = _grp createUnit ["LOGIC", (getPosworld _radio), [], 0, "can_collide"];
		_log attachto [_radio];
		_rndspeech = selectRandom _speech;
		_rndmusic = selectRandom _music;

		{
			if (_radio in fmradio) then {
				[_log, (_x select 0)] call CBA_fnc_globalSay3d;

				_time = _x select 1;
				_i = 0;
				while {(_radio in fmradio) && (_i < _time)} do {
					sleep 1;
					_i = _i + 1;
				};
				sleep 0.1;
			};
		} foreach [_rndspeech, _rndmusic];
	};
};
