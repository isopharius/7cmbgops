_radio = _this select 0;

_speech = ["speech_ra_1","speech_ra_2","speech_ra_3","speech_ra_4","speech_ra_5","speech_ra_6","apeech_ra_7",/*"jingle_ra_1",*/"speech_rs_1","speech_rs_2","speech_rs_3","speech_rs_4","speech_rs_5","speech_rs_6","speech_rs_7"/*,"jingle_rs_1"*/];
_music = ["music_ra_1","music_ra_2","music_ra_3","music_ra_4","music_ra_5","music_ra_6","music_ra_7","music_ra_8","music_ra_9","music_ra_10","music_ra_11","music_rs_1","music_rs_2","music_rs_3","music_rs_4","music_rs_5","music_rs_6","music_rs_7","music_rs_8","music_rs_9","music_rs_10","music_rs_11","viet_bird","viet_bornwild","viet_caldreaming","viet_caligirls","viet_crosstown","viet_evedestruction","viet_foxeylady","viet_goodlovin","viet_gottagetout","viet_greenriver","viet_badmoon","viet_fortunateson","viet_runthroughjungle","viet_hellovietnam","viet_heyjoe","viet_houserisingsun","viet_ontheroad","viet_paintitblack","viet_purplehaze","viet_satisfaction","viet_sitdockbay","viet_theend","viet_theseboots","viet_toldnation","viet_trackmytears","viet_wagner","viet_whatsound","viet_whiterabbit","viet_whitershade","viet_whodoyoulove","viet_wildthing","viet_wipeout","viet_wooly"];

_rndspeech = _speech call bis_fnc_selectRandom;
[_radio, _rndspeech] call CBA_fnc_globalSay3d;

_rndmusic = _music call bis_fnc_selectRandom;
[_radio, _rndmusic] call CBA_fnc_globalSay3d;