class seven
{
	tag = "seven";
	class init
	{
		file = "\7cmbgops";

		class init_map {
			postInit = 1;
		};
		class init_custom {
			postInit = 1;
		};
		class init_alive {
			postInit = 1;
		};
		class init_ares {
			postInit = 1;
		};
		class init_ace {
			postInit = 1;
		};
	};
	class funkunfusion
	{
		file = "\7cmbgops\functions";

		class groupname {};
		class attachmrzr {};
		class fmradio {};
		class adminmenudef {};
		class briefing {
			postInit = 1;
		};
		class garageNew {};
		class getloadout {};
		class setloadout {};
		class jumpout {};
		class deployMedicTent {};
		class deploySandbag {};
		class removeMedicTent {};
		class removeSandbag {};
		class rearmChopper {};
		class rearmPlanes {};
		class rearmVehicle {};
		class SetPitchBankYaw {};
		class helipad_light {};
		class helipad_light_remove {};
		class SHK_moveObjects {};
		class Teleport {};
	};
	class loadouts
	{
		file = "\7cmbgops\scripts\loadouts";

		class vehloadoutfull {};
		class vehloadoutmed {};
	};
	class satcom
	{
		file = "\7cmbgops\scripts\pxs_satcom_a3";

		class init_satellite {
			postInit = 1;
		};
		class time_function {};
		class time_view {};
		class coordinates_function {};
		class coordinates_view {};
		class adjustCamera {};
		class updateCamera {};
		class closeCamera {};
		class view_satellite {};
		class key_function {};
		class mouseZChanged {};
		class key_main {};
		class start_satellite {};
		class redefine_position {};
	};
	class train360
	{
		file = "\7cmbgops\scripts\360";

		class init360 {};
		class animate_target {};
		class bullet_camera {};
		class bullet_trace {};
		class check_impact {};
		class create_balloon_target {};
		class create_skeet {};
		class create_soldier {};
		class create_target {};
		class generate_targets {};
		class get_first_intersection {};
		class king_of_the_hill {};
		class on_hit {};
		class reset_stats {};
		class toggle_bullet_camera {};
		class toggle_path_tracing {};
	};
	class NRD {
		file = "\7cmbgops\scripts\nradio";
		class status {};
		class play {};
		class stop {};
		class volume {};
		class song {};
		class removeFromProfile {};
		class addStation {};
		class fillStations {};
		class start {};
		class startAdd {};
	};
  class SAF {
    #define seven_fncS
      	#include "\7cmbgops\scripts\sushi\core\init.cpp"
        #include "\7cmbgops\scripts\sushi\breach\init.cpp"
    #undef seven_fncS
  };
  class defuse {
		file = "\7cmbgops\scripts\defuse\functions";
		class searchAction {};
		class bombTimer {};
		class codeCompare {};
		class wireCompare {};
  };
  class sandstorm {
		file = "\7cmbgops\scripts\sandstorm";
		class getInfoWorld {};
		class Sand_Client {};
		class Sand_Server {};
		class Sand_Snow_Init {};
  };
};
