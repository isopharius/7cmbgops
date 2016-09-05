class seven
{
	tag = "seven";
	class funkunfusion
	{
		file = "\7cmbgops\functions";

		class briefing {
			postInit = 1;
		};
		class IntLight {
			postInit = 1;
		};
		class groupname {};
		class attachmrzr {};
		class fmradio {};
		class adminmenuDef {};
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
		class spawnRooftopStaticWeapons {};
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
	class defuse {
		file = "\7cmbgops\scripts\defuse";
		class searchAction {};
	};
	/*class breach_safplug {
		file = "\7cmbgops\scripts\sushi\breach\fncs";
		//class breachGetSettings { preInit = 1; };
		//class breachPostInit { postInit = 1; };
		class breachFiredEh {};
		class breachGetTargetDoors {};
		class breachOpenDoor {};
		class breachGetBldDoorArr {};
		class breachLockDoor {};
		class breachCloseAllDoors {};
		class breachManageLockedDoor {};
		class breachCheckDoor {};
		class breachCheckLock {};
		class breachDoorIsChecked {};
		class breachPickLock {};
		class breachSetExplosive {};
		class breachHasExplosives {};
		class breachDetonate {};
		class breachStun {};
		class lockpickcheck{};
		class checkexplosive {};
	};
	class core {
		file = "\7cmbgops\scripts\sushi\core\fncs";
		class preInit { preInit = 1; };
		class showStatus {};
	};*/
		class Control {
			file = "\7cmbgops\scripts\Artillery\Control";
			class Splash {};
			class Tube {};
			class ProcessFireMission {};
		};
		class Dialog {
			file = "\7cmbgops\scripts\Artillery\Dialog";
			class Adjust {};
			class AimpointHelp {};
			class Assets {};
			class ChangeTube {};
			class ClearAdjust {};
			class Control {};
			class ControlAsset {};
			class DisplayWarheads {};
			class EndMission {};
			class InputAimpoint {};
			class RefreshMissions {};
			class ReleaseAsset {};
			class SelectAsset {};
			class SelectFuse {};
			class SelectMission {};
			class Transmit {};
		};
		class Misc {
			file = "\7cmbgops\scripts\Artillery\Misc";
			class CommsPlay {};
		};
		class Special {
			file = "\7cmbgops\scripts\Artillery\Special";
			class Fired {};
			class WP {};
			class LaserGuided {};
			class SelfGuided {};
			class GuideProjectile {};
		};
		class Airburst {
			file = "\7cmbgops\scripts\Artillery\Airburst";
			class AirburstFire2 {};
			class AirburstFireHigh {};
			class AirburstFireLow {};
			class AirburstFireMed {};
			class AirburstHit {};
			class CallShrapnel {};
			class FireShrapnel {};
			class OriginToTarget {};
		};
	class storm {
		file = "\7cmbgops\scripts\AL_storm";
		class al_duststorm {};
		class al_monsoon {};
		class al_tornado {};
		class al_tornado_effect {};
		class alias_dust_wall {};
		class alias_duststorm_effect {};
		class alias_hunt {};
		class alias_monsoon_effect {};
	};
};
