private ["_userPlaylist", "_keyPlay", "_keyNext", "_keyPre", "_keyVolUp", "_keyVolDown", "_CLAY_CarRadio_KeyPressed"];_userPlaylist = [  ];

_keyPlay = 197; //  Key number 'PLAY/PAUSE' - default PAUSE
_keyNext = 205; //  Key number 'NEXT TRACK' - default RIGHT ARROW
_keyPre = 203; //  Key number 'PREVIOUS TRACK' - default LEFT ARROW
_keyVolUp = 200; //  Key number 'VOLUME UP' - default UP ARROW
_keyVolDown = 208; //  Key number 'VOLUME DOWN' - default DOWN ARROW

sleep 0.1;
#include "\userconfig\CLAY_CarRadio\CLAY_CarRadio.hpp";

CLAY_CarRadio_KeyPlay    = _keyPlay;
CLAY_CarRadio_KeyNext    = _keyNext;
CLAY_CarRadio_KeyPre     = _keyPre;
CLAY_CarRadio_KeyVolUp   = _keyVolUp;
CLAY_CarRadio_KeyVolDown = _keyVolDown;

_CLAY_CarRadio_KeyPressed = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call seven_fnc_key"];

If (isNil "CLAY_RadioAddMusic") Then {CLAY_RadioAddMusic = []};
If (isNil "CLAY_RadioAddVehicles") Then {CLAY_RadioAddVehicles = []};
If (isNil "CLAY_RadioNoVehicles") Then {CLAY_RadioNoVehicles = []};
If (isNil "CLAY_RadioShowTooltips") Then {CLAY_RadioShowTooltips = false};

/*
_trigger1 = createTrigger ["EmptyDetector", [0,0,0]];
_trigger1 setTriggerArea [0, 0, 0, false];
_trigger1 setTriggerActivation ["NONE", "PRESENT", true];
_trigger1 setTriggerStatements ["(('Car' countType [(vehicle player)] > 0) || (typeOf (vehicle player) in CLAY_RadioAddVehicles)) && !(typeOf (vehicle player) in CLAY_RadioNoVehicles)", "CLAY_RadioVeh = vehicle player; CLAY_ID_RADIO = CLAY_RadioVeh addAction ['Car Radio',seven_fnc_radio];", "CLAY_RadioEndTimer = true; CLAY_RadioPlaying = false; playMusic ''; CLAY_RadioVeh removeAction CLAY_ID_RADIO; CLAY_RadioVeh = nil;"];
*/

CLAY_RadioPlaying = false;
CLAY_RadioEndTimer = true;

CLAY_RadioPlayList =
[
	["viet_bird", "Surfin Bird", 140],
	["viet_bornwild", "Born to be Wild", 153],
	["viet_caldreaming", "California Dreaming", 153],
	["viet_caligirls", "California Girl", 153],
	["viet_crosstown", "Crosstown Traffic", 153],
	["viet_evedestruction", "Eve of Destruction", 153],
	["viet_foxeylady", "Foxy Lady", 153],
	["viet_goodlovin", "Good Lovin", 153],
	["viet_gottagetout", "Gotta get out of this place", 153],
	["viet_greenriver", "Green River", 156],
	["viet_badmoon", "Bad Moon Rising", 153],
	["viet_fortunateson", "Fortunate Son", 153],
	["viet_runthroughjungle", "Run through the Jungle", 153],
	["viet_hellovietnam", "Hello Vietnam", 153],
	["viet_heyjoe", "Hey Joe", 153],
	["viet_houserisingsun", "House of the Rising Sun", 153],
	["viet_ontheroad", "On the road again", 153],
	["viet_paintitblack", "Paint it Black", 153],
	["viet_purplehaze", "Purple Haze", 153],
	["viet_satisfaction", "Satisfaction", 153],
	["viet_sitdockbay", "Sitting by the dock of the bay", 153],
	["viet_theend", "The End", 153],
	["viet_helviet_thesebootslovietnam", "These boots are made for walking", 153],
	["viet_toldnation", "Told Nation", 153],
	["viet_trackmytears", "Track of my tears", 153],
	["viet_wagner", "Ride of the Valkyries", 153],
	["viet_whatsound", "What Sound", 153],
	["viet_whiterabbit", "White Rabbit", 153],
	["viet_whitershade", "Whiter shade of pale", 153],
	["viet_whodoyoulove", "Who do you love", 153],
	["viet_wildthing", "Wild Thing", 153],
	["viet_wipeout", "Wipe Out", 153],
	["viet_wooly", "Wooly Bully", 153]
];

CLAY_RadioTrack = 0;
CLAY_RadioVol = 0.5;
CLAY_RadioVolStep = 10;

CLAY_RadioSrc = 1;
CLAY_RadioRepeat = false;
CLAY_RadioRandom = false;
CLAY_RadioKeyColor = 1;
CLAY_RadioDisplay = 9;
CLAY_RadioColor = "Black";
