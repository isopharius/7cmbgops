class seven
{
	tag = "seven";

	class init
	{
		file = "\7cmbgops";
		class init_template {};
		class init_ace {};
		class init_alive {};
		class init_ares {};
		class init_custom {};
		class init_map {};
	};
	class funkunfusion
	{
		file = "\7cmbgops\functions";

		class Ares_AddRhsReinforcementPools {};
		class attachmrzr {};
		class playradio {};
		class adminmenudef {};
		class briefing {};
		class garageNew {};
		class getloadout {};
		class setloadout {};
		class suicidebomber {};
		class ws_assassins {};
		class halo {};
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
	class loadouts
	{
		file = "\7cmbgops\scripts\loadouts";

		class vehloadoutfull {};
		class vehloadoutmed {};
	};
	class satcom
	{
		file = "\7cmbgops\scripts\pxs_satcom_a3";

		class init_satellite {};
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
	class Rtask
	{
		file = "\7cmbgops\scripts\Rtask";

		class addactions {};
		class capture {};
		class disarm_nuke {};
		class dragmat {};
		class dropmat {};
		class getintel {};
		class grab {};
		class iedblow {};
		class loadmat {};
		class uavdata {};
		class unvehtower {};
		class vehtower {};
		class missionAir {};
		class missionClear {};
		class missionSupport {};
		class makeAirOps {};
		class makeClearOps {};
		class makeSupportOps {};
		class removeTask {};
		class removeTaskLocal {};
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
	class insurgency
	{
		file = "\7cmbgops\scripts\insurgency";

		class common_defines {};
		class ins_briefing {};
		class ins_init {};
		class addactionMP {};
		class cacheKilled {};
		class cacheKilledText {};
		class createIntel {};
		class endMission {};
		class findBuildings {};
		class getCountBuildingPositions {};
		class handlerRegister {};
		class intelDrop {};
		class intelPickup {};
		class pickedUpIntel {};
		class RandomBuildingPosition {};
		class setupCache {};
		class spawnCache {};
		class SpawnIntel {};
		class CallToPrayer {};
		class prayerLoop {};
		class urbanAreas {};
	};/*
	class carradio
	{
		file = "\7cmbgops\scripts\carradio";

		class initCarRadio {};
		class controls {};
		class display {};
		class editor {};
		class key {};
		class lbdrop {};
		class play {};
		class playlist {};
		class radio {};
		class settings {};
	};*/
};