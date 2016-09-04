class CfgPatches
{
	class 7cmbgops
	{
		requiredVersion = 0.1;
		author[] = { "7CMBG" };
		authorUrl = "http://7cmbg.com";
		version = 0.1;
		weapons[] = {};
		units[] = {};

		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"cba_xeh_a3",
			"A3_weapons_F",
			"asdg_jointrails",
			"ons_asdg_jr",
			"ace_compat_ons_a3",
			"7cmbg_sounds"
		};
	};
};

#include "scripts\Artillery\zReconfig\Ammo\config.cpp"

class CfgFunctions
{
	#include "functions\cfgfunctions.hpp"
};

//dialogs
#include "scripts\Artillery\Menu.hpp"
#include "scripts\sushi\core\cfg\common_saf.cpp"
#include "scripts\sushi\breach-settings.cpp"
#include "scripts\nradio\nradio.hpp"
#include "scripts\pxs_satcom_a3\init_interface.hpp"
#include "scripts\defuse\common.hpp"
#include "scripts\defuse\explosivePad.hpp"

//CBA XEH
#include "description-xeh.ext"

class CfgVehicles
{
	//#include "scripts\loadouts\cfgloadouts.hpp"
};

/*
class CfgRoles
{
     class Infantry
     {
          displayName = "7CMBG Infantry";
          icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
     };
};
*/

class CfgSounds
{
	sounds[] = {crowd,muezzin1,muezzin2,muezzinshort1,muezzinshort2,muezzinshort3,muezzinshort4,muezzinmusic1,muezzinmusic2,Alarm,allahu_akbar1,allahu_akbar2,allahu_akbar3,jihad,scream1,scream2,scream3,scream4,scream5,scream6,Hint,Hit,Buzzer};

	#include "scripts\defuse\cfgSounds.hpp"
	#include "scripts\Artillery\cfgSounds.hpp"

	class uragan_1
	{
		name = "uragan_1";
		sound[] = {"\7cmbg_sounds\storm\uragan_1.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class uragan_end
	{
		name = "uragan_end";
		sound[] = {"\7cmbg_sounds\storm\uragan_end.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class bcg_wind
	{
		name = "bcg_wind";
		sound[] = {"\7cmbg_sounds\storm\bcg_wind.ogg", db+5, 1};
		titles[] = {1, ""};
	};
	class rafala_1
	{
		name = "rafala_1";
		sound[] = {"\7cmbg_sounds\storm\rafala_1.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_2
	{
		name = "rafala_2";
		sound[] = {"\7cmbg_sounds\storm\rafala_2.ogg", db+5, 1};
		titles[] = {1, ""};
	};
	class rafala_4_dr
	{
		name = "rafala_4_dr";
		sound[] = {"\7cmbg_sounds\storm\rafala_4_dr.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_5_st
	{
		name = "rafala_5_st";
		sound[] = {"\7cmbg_sounds\storm\rafala_5_st.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_6
	{
		name = "rafala_6";
		sound[] = {"\7cmbg_sounds\storm\rafala_6.ogg", db+15, 1};
		titles[] = {1, ""};
	};
	class rafala_7
	{
		name = "rafala_7";
		sound[] = {"\7cmbg_sounds\storm\rafala_7.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_8
	{
		name = "rafala_8";
		sound[] = {"\7cmbg_sounds\storm\rafala_8.ogg", db+15, 1};
		titles[] = {1, ""};
	};
	class rafala_9
	{
		name = "rafala_9";
		sound[] = {"\7cmbg_sounds\storm\rafala_9.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class sandstorm
	{
		name = "sandstorm";
		sound[] = {"\7cmbg_sounds\storm\sandstorm.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class alarm_prepare {
		name = "alarm_prepare";
		sound[] = {"\7cmbg_sounds\effects\alarm-prepare.ogg", 1, 1};
		titles[] = {0, ""};
	};
	class alarm_go {
		name = "alarm_go";
		sound[] = {"\7cmbg_sounds\effects\sounds\alarm-go.ogg", 1, 1};
		titles[] = {0, ""};
	};
	class crowd
	{
		name	 = "crowd";
		sound[]  = {"\7cmbg_sounds\crowd.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzin1
	{
		name	 = "muezzin1";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzin1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzin2
	{
		name	 = "muezzin2";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzin2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinshort1
	{
		name	 = "muezzinshort1";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinshort1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinshort2
	{
		name	 = "muezzinshort2";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinshort2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinshort3
	{
		name	 = "muezzinshort3";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinshort3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinshort4
	{
		name	 = "muezzinshort4";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinshort4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinmusic1
	{
		name	 = "muezzinmusic1";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinmusic1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class muezzinmusic2
	{
		name	 = "muezzinmusic2";
		sound[]  = {"\7cmbg_sounds\muezzin\muezzinmusic2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class Alarm
	{
		name	 = "Alarm";
		sound[]  = {"\7cmbg_sounds\Alarm.ogg", 2, 1, 100};
		titles[] = {};
	};
	class allahu_akbar1
	{
		name     = "allahu_akbar1";
		sound[]  = {"\7cmbg_sounds\jihad\allahu_akbar1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class allahu_akbar2
	{
		name     = "allahu_akbar2";
		sound[]  = {"\7cmbg_sounds\jihad\allahu_akbar2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class allahu_akbar3
	{
		name     = "allahu_akbar3";
		sound[]  = {"\7cmbg_sounds\jihad\allahu_akbar3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class jihad
	{
		name     = "jihad";
		sound[]  = {"\7cmbg_sounds\jihad\jihad.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream1
	{
		name     = "scream1";
		sound[]  = {"\7cmbg_sounds\scream\scream1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream2
	{
		name     = "scream2";
		sound[]  = {"\7cmbg_sounds\scream\scream2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream3
	{
		name     = "scream3";
		sound[]  = {"\7cmbg_sounds\scream\scream3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream4
	{
		name     = "scream4";
		sound[]  = {"\7cmbg_sounds\scream\scream4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream5
	{
		name     = "scream5";
		sound[]  = {"\7cmbg_sounds\scream\scream5.ogg", 2, 1, 100};
		titles[] = {};
	};
	class scream6
	{
		name     = "scream6";
		sound[]  = {"\7cmbg_sounds\scream\scream6.ogg", 2, 1, 100};
		titles[] = {};
	};
	class Hint
	{
		name = "Hint";
		sound[] = {"\7cmbg_sounds\Hint.ogg", 0.10, 1};
		titles[] = {};
	};
	class Hit
	{
		name = "Hit";
		sound[] = {"\7cmbg_sounds\Hit.ogg", 0.10, 1};
		titles[] = {};
	};
	class Buzzer
	{
		name = "Buzzer";
		sound[] = {"\7cmbg_sounds\Buzzer.ogg", 0.30, 1};
		titles[] = {};
	};
	class jingle_rs_1
	{
		name = "jingle_rs_1";
		sound[] = {"\7cmbg_sounds\radio_suno\jingle_rs_1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_1
	{
		name = "music_rs_1";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_2
	{
		name = "music_rs_2";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_3
	{
		name = "music_rs_3";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_4
	{
		name = "music_rs_4";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_5
	{
		name = "music_rs_5";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_5.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_6
	{
		name = "music_rs_6";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_6.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_7
	{
		name = "music_rs_7";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_7.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_8
	{
		name = "music_rs_8";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_8.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_9
	{
		name = "music_rs_9";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_9.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_10
	{
		name = "music_rs_10";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_10.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_rs_11
	{
		name = "music_rs_11";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_11.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_1
	{
		name = "speech_rs_1";
		sound[] = {"\7cmbg_sounds\radio_suno\music_rs_11.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_2
	{
		name = "speech_rs_2";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_3
	{
		name = "speech_rs_3";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_4
	{
		name = "speech_rs_4";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_5
	{
		name = "speech_rs_5";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_5.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_6
	{
		name = "speech_rs_6";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_6.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_rs_7
	{
		name = "Speech_RS_7";
		sound[] = {"\7cmbg_sounds\radio_suno\speech_rs_7.ogg", 2, 1, 100};
		titles[] = {};
	};
	class jingle_ra_1
	{
		name = "jingle_ra_1";
		sound[] = {"\7cmbg_sounds\radio_accion\jingle_ra_1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_1
	{
		name = "music_ra_1";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_2
	{
		name = "music_ra_2";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_3
	{
		name = "music_ra_3";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_4
	{
		name = "music_ra_4";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_5
	{
		name = "music_ra_5";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_5.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_6
	{
		name = "music_ra_6";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_6.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_7
	{
		name = "music_ra_7";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_7.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_8
	{
		name = "music_ra_8";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_8.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_9
	{
		name = "music_ra_9";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_9.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_10
	{
		name = "music_ra_10";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_10.ogg", 2, 1, 100};
		titles[] = {};
	};
	class music_ra_11
	{
		name = "music_ra_11";
		sound[] = {"\7cmbg_sounds\radio_accion\music_ra_11.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_1
	{
		name = "speech_ra_1";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_1.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_2
	{
		name = "speech_ra_2";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_2.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_3
	{
		name = "speech_ra_3";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_3.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_4
	{
		name = "speech_ra_4";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_4.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_5
	{
		name = "speech_ra_5";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_5.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_6
	{
		name = "speech_ra_6";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_6.ogg", 2, 1, 100};
		titles[] = {};
	};
	class speech_ra_7
	{
		name = "speech_ra_7";
		sound[] = {"\7cmbg_sounds\radio_accion\speech_ra_7.ogg", 2, 1, 100};
		titles[] = {};
	};
	class viet_bird
	{
		name = "Surfin Bird";
		sound[] = {"\7cmbg_sounds\vietnam\the_trashmen-surfin_bird.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_bornwild
	{
		name = "Born to be Wild";
		sound[] = {"\7cmbg_sounds\vietnam\steppenwolf-born_to_be_wild.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_caldreaming
	{
		name = "California Dreaming";
		sound[] = {"\7cmbg_sounds\vietnam\mamas_and_the_papas-california_dreaming.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_caligirls
	{
		name = "California Girls";
		sound[] = {"\7cmbg_sounds\vietnam\beach_boys-california_girls.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_crosstown
	{
		name = "Crosstown Traffic";
		sound[] = {"\7cmbg_sounds\vietnam\jimi_hendrix-crosstown_traffic.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_evedestruction
	{
		name = "Eve of Destruction";
		sound[] = {"\7cmbg_sounds\vietnam\mcguire_barry-eve_of_destruction.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_foxeylady
	{
		name = "Foxy Lady";
		sound[] = {"\7cmbg_sounds\vietnam\jimi_hendrix-foxey_lady.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_goodlovin
	{
		name = "Good Lovin";
		sound[] = {"\7cmbg_sounds\vietnam\the_young_rascals-goodlovin.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_gottagetout
	{
		name = "Gotta get out of this place";
		sound[] = {"\7cmbg_sounds\vietnam\animals-weve_gotta_get_out_of_this_place.ogg",2, 1, 100};
	};
	class viet_greenriver
	{
		name = "Green River";
		sound[] = {"\7cmbg_sounds\vietnam\creedence_clearwater_revival-green_river.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_badmoon
	{
		name = "Bad Moon Rising";
		sound[] = {"\7cmbg_sounds\vietnam\creedence_clearwater_revival-bad_moon_rising.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_fortunateson
	{
		name = "Fortunate Son";
		sound[] = {"\7cmbg_sounds\vietnam\creedence_clearwater_revival-fortunate_son.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_runthroughjungle
	{
		name = "Run through the Jungle";
		sound[] = {"\7cmbg_sounds\vietnam\creedence_clearwater_revival-run_through_the_jungle.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_hellovietnam
	{
		name = "Hello Vietnam";
		sound[] = {"\7cmbg_sounds\vietnam\johnnie_wright-hello_vietnam.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_heyjoe
	{
		name = "Hey Joe";
		sound[] = {"\7cmbg_sounds\vietnam\jimi_hendrix-hey_joe.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_houserisingsun
	{
		name = "House of the Rising Sun";
		sound[] = {"\7cmbg_sounds\vietnam\animals-house_of_the_rising_sun.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_ontheroad
	{
		name = "On the road again";
		sound[] = {"\7cmbg_sounds\vietnam\canned_heat-on_the_road_again.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_paintitblack
	{
		name = "Paint it Black";
		sound[] = {"\7cmbg_sounds\vietnam\rolling_stones-paint_it_black.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_purplehaze
	{
		name = "Purple Haze";
		sound[] = {"\7cmbg_sounds\vietnam\jimi_hendrix-purple_haze.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_satisfaction
	{
		name = "Satisfaction";
		sound[] = {"\7cmbg_sounds\vietnam\rolling_stones-satisfaction.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_sitdockbay
	{
		name = "Sitting by the dock of the bay";
		sound[] = {"\7cmbg_sounds\vietnam\marvin_gaye-sitting_on_a_dock_by_the_bay.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_theend
	{
		name = "The End";
		sound[] = {"\7cmbg_sounds\vietnam\doors-the_end.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_theseboots
	{
		name = "These boots are made for walking";
		sound[] = {"\7cmbg_sounds\vietnam\nancy_sinatra-these_boots_are_made_for_walking.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_toldnation
	{
		name = "Told Nation";
		sound[] = {"\7cmbg_sounds\vietnam\tom_paxton-lyndon_toldnation.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_trackmytears
	{
		name = "Track of my tears";
		sound[] = {"\7cmbg_sounds\vietnam\smokey_robinson-track_of_my_tears.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_wagner
	{
		name = "Ride of the Valkyries";
		sound[] = {"\7cmbg_sounds\vietnam\wagner-ride_of_valkyries.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_whatsound
	{
		name = "What Sound";
		sound[] = {"\7cmbg_sounds\vietnam\buffalo_springfield-whatsound.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_whiterabbit
	{
		name = "White Rabbit";
		sound[] = {"\7cmbg_sounds\vietnam\jefferson_airplane-white_rabbit.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_whitershade
	{
		name = "Whiter shade of pale";
		sound[] = {"\7cmbg_sounds\vietnam\procol_harum-whiter_shade_of_pale.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_whodoyoulove
	{
		name = "Who do you love";
		sound[] = {"\7cmbg_sounds\vietnam\juicy_lucy-whodoyoulove.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_wildthing
	{
		name = "Wild Thing";
		sound[] = {"\7cmbg_sounds\vietnam\jimi_hendrix-wild_thing.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_wipeout
	{
		name = "Wipe Out";
		sound[] = {"\7cmbg_sounds\vietnam\the_surfaris-wipe_out.ogg",2, 1, 100};
		titles[] = {};
	};
	class viet_wooly
	{
		name = "Wooly Bully";
		sound[] = {"\7cmbg_sounds\vietnam\sam_the_sham_and_the_pharaohs-wooly_bully.ogg",2, 1, 100};
		titles[] = {};
	};
	class mesfxsound
	{
		name = "mesfxsound";
		sound[]={"\7cmbg_sounds\me\sfxsound.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound2
	{
		name = "mesfxsound2";
		sound[]={"\7cmbg_sounds\me\sfxsound2.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound3
	{
		name = "mesfxsound3";
		sound[]={"\7cmbg_sounds\me\sfxsound3.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound4
	{
		name = "mesfxsound4";
		sound[]={"\7cmbg_sounds\me\sfxsound4.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound5
	{
		name = "mesfxsound5";
		sound[]={"\7cmbg_sounds\me\sfxsound5.ogg",2,1};
		titles[] = {};
	};

    class mesfxsound6
	{
		name = "mesfxsound6";
		sound[]={"\7cmbg_sounds\me\sfxsound2.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound7
	{
		name = "mesfxsound7";
		sound[]={"\7cmbg_sounds\me\sfxsound7.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound8
	{
		name = "sfxsound8";
		sound[]={"\7cmbg_sounds\me\sfxsound8.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound9
	{
		name = "menews1";
		sound[]={"\7cmbg_sounds\me\news1.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound10
	{
		name = "memusic1";
		sound[]={"\7cmbg_sounds\me\music1.ogg",2,1};
		titles[] = {};
	};

	class mesfxsound11
	{
		name = "memusic2";
		sound[]={"\7cmbg_sounds\me\music2.ogg",2,1};
		titles[] = {};
	};

	class kunduznews
	{
		name = "mekunduznews";
		sound[]={"\7cmbg_sounds\me\kunduznews.ogg",2,1};
		titles[] = {};
	};

	class SanginnewsBBC
	{
		name = "meSanginnewsBBC";
		sound[]={"\7cmbg_sounds\me\SanginnewsBBC.ogg",2,1};
		titles[] = {};
	};

    class meprayer2
	{
		name = "meprayer2";
		sound[]={"\7cmbg_sounds\me\prayer2.ogg",2,1};
		titles[] = {};
	};

	class meBritishnews
	{
		name = "Britishnews";
		sound[]={"\7cmbg_sounds\me\Britishnews.ogg",2,1};
		titles[] = {};
	};

	 class ISISpropoganda
	{
		name = "ISISpropoganda";
		sound[]={"\7cmbg_sounds\me\ISISpropoganda.ogg",2,1};
		titles[] = {};
	};

	class IEDchatter
	{
		name = "IEDchatter";
		sound[]={"\7cmbg_sounds\me\IEDchatter.ogg",2,1};
		titles[] = {};
	};

	class arab_talking
	{
		name = "arab_talking";
		sound[]={"\7cmbg_sounds\me\arab_talking.ogg",2,1};
		titles[] = {};
	};

	 class arabicsong1
	{
		name = "arabicsong1";
		sound[]={"\7cmbg_sounds\me\arabicsong1.ogg",2,1};
		titles[] = {};
	};

	class arabicsong2
	{
		name = "arabicsong2";
		sound[]={"\7cmbg_sounds\me\arabicsong2.ogg",2,1};
		titles[] = {};
	};
	class africancity
	{
		name = "africancity";
		sound[]={"\7cmbg_sounds\afr\africancity.ogg",2,1};
		titles[] = {};
	};

	class africancity2
	{
		name = "africancity2";
		sound[]={"\7cmbg_sounds\afr\africancity2.ogg",2,1};
		titles[] = {};
	};

	class africancity3
	{
		name = "africancity3";
		sound[]={"\7cmbg_sounds\afr\africancity3.ogg",2,1};
		titles[] = {};
	};

	class africancity4
	{
		name = "africancity4";
		sound[]={"\7cmbg_sounds\afr\africancity4.ogg",2,1};
		titles[] = {};
	};

	class africancity5
	{
		name = "africancity5";
		sound[]={"\7cmbg_sounds\afr\africancity5.ogg",2,1};
		titles[] = {};
	};
	class africancity6
	{
		name = "africancity6";
		sound[]={"\7cmbg_sounds\afr\africancity6.ogg",2,1};
		titles[] = {};
	};

	class africansinging
	{
		name = "africansinging";
		sound[]={"\7cmbg_sounds\afr\africansinging.ogg",2,1};
		titles[] = {};
	};

	class drums
	{
		name = "drums";
		sound[]={"\7cmbg_sounds\afr\drums.ogg",2,1};
		titles[] = {};
	};

	class drums2
	{
		name = "drums2";
		sound[]={"\7cmbg_sounds\afr\drums2.ogg",2,1};
		titles[] = {};
	};

	class bokonews
	{
		name = "bokonews";
		sound[]={"\7cmbg_sounds\afr\bokonews.ogg",2,1};
		titles[] = {};
	};

	class afrBritishnews
	{
		name = "afrBritishnews";
		sound[]={"\7cmbg_sounds\afr\Britishnews.ogg",2,1};
		titles[] = {};
	};

	class sudannews1
	{
		name = "sudannews1";
		sound[]={"\7cmbg_sounds\afr\sudannews1.ogg",2,1};
		titles[] = {};
	};

	class sudannews2
	{
		name = "sudannews2";
		sound[]={"\7cmbg_sounds\afr\sudannews2.ogg",2,1};
		titles[] = {};
	};

	class africansong1
	{
		name = "africansong1";
		sound[]={"\7cmbg_sounds\afr\africansong1.ogg",2,1};
		titles[] = {};
	};

	class africansong2
	{
		name = "africansong2";
		sound[]={"\7cmbg_sounds\afr\africansong2.ogg",2,1};
		titles[] = {};
	};

	class africansong3
	{
		name = "africansong3";
		sound[]={"\7cmbg_sounds\afr\africansong3.ogg",2,1};
		titles[] = {};
	};
};

class CfgMusic
{
	tracks[]={"MKY_Blizzard","MKY_Snowfall"};

	class MKY_Blizzard
	{
		name = "";
		sound[] = {"\7cmbg_sounds\effects\m0nkey_blizzard.ogg", db+0, 1.0};
	};
	class MKY_Snowfall
	{
		name = "";
		sound[] = {"\7cmbg_sounds\effects\m0nkey_snowfall.ogg", db+0, 1.0};
	};
};
