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
			"Ares",
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"cba_xeh_a3",
			"A3_weapons_F",
			"ATLAS_Water",
			"asdg_jointrails",
			"ons_optics",
			"ons_rifles",
			"ons_asdg_jr"
		};
	};
};

class CfgFunctions
{
	#include "functions\cfgfunctions.hpp"
	#include "scripts\LT\cfgfunctions.hpp"
};

class CfgNotifications
{
	#include "scripts\Rtask\cfgnotifications.hpp"
};

#include "scripts\LT\LTmenu.hpp"
#include "scripts\pxs_satcom_a3\init_interface.hpp"
#include "scripts\airboss\dialog.hpp"
#include "scripts\carradio\dialog.hpp"

#include "description-xeh.ext"

class CfgVehicles
{
	#include "scripts\loadouts\cfgloadouts.hpp"

	class ATLAS_B_LHD_helper;
	class ATLAS_ONS_LHD_helper: ATLAS_B_LHD_helper
	{	
		class eventhandlers
		{
			init = "[(_this select 0),['ATLAS_LHD_1','ATLAS_LHD_2','ATLAS_LHD_3','ATLAS_LHD_4','ATLAS_LHD_5','ATLAS_LHD_5a','ATLAS_LHD_6','ATLAS_LHD_7','ATLAS_LHD_house_1','ATLAS_LHD_house_2','ATLAS_LHD_elev_1','ATLAS_LHD_elev_2','ATLAS_LHD_Light2','ATLAS_LHD_Int_1','ATLAS_LHD_Int_2','ATLAS_LHD_Int_3']] execVM '\ATLAS_Water\scripts\large_object_attach.sqf';";
		};
	};
};