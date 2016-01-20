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

#include "scripts\LT\LTmenu.hpp"
#include "scripts\pxs_satcom_a3\init_interface.hpp"

#include "description-xeh.ext"

class CfgVehicles
{
	#include "scripts\loadouts\cfgloadouts.hpp"
};