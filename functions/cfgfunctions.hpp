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

		class Ares_AddRhsReinforcementPools {
			postInit = 1;
		};
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
		class FSFSV_CallBackpackToBack {};
		class FSFSV_CallBackpackToFront {};
		class FSFSV_TestPlayerBackpackBack {};
		class FSFSV_TestPlayerBackpackFront {};
		class FSFSV_QuellePosition {};
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
		class WerthlesHeadless {};
	};
	class ambience
	{
		file = "\7cmbgops\scripts\ambience";

		class init_ambience {};
		class SpyderAmbiance {};
		class getunittypes {};
		class loopcheck {};
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
	class airboss
	{
		file = "\7cmbgops\scripts\airboss";

		class lha_main {};
		class lha_BayOver {};
		class lha_BaySelect {};
		class lha_BayStatusUpdate {};
		class lha_UpdateListBox {};
		class lha_VehicleReturn {};
		class lha_VehicleService {};
		class lha_VehicleSpawn {};
		class lha_object_create {};
		class lha_VehicleSpawnBox {};
		class lha_ui_debarkationControl {};
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
};
