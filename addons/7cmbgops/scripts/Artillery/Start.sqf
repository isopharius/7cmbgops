// Starts the artillery system
sleep 0.1;
if (((getMarkerPos "dtaTest") select 0) > 0) exitWith {hint "DTA TEST MODE ACTIVE"};

dtaVersion = "v0.34";
dtaReady = false;
dtaDebug = false;
dtaNoDelay = false;
dtaRealisticTimes = false;
dtaNoInitialInaccuracy = true;
dtaDisallowMapclick = true;
dtaTrackRounds = false;
dtaScriptMode = false;

dtaKey = 0xDB;

dtaPos = [0,0];
dtaX = 0;
dtaY = 0;
dtaAdjustX = 0;
dtaAdjustY = 0;
dtaElevation = 0;
dtaSheafSize = [];
// Has an aimpoint been entered?
dtaHaveAimpoint = false;
// The x/y values that are displayed to the player (not necessarily the true x/y value used by the system)
dtaXdisplay = 0;
dtaYdisplay = 0;
// The real (BIS) values
dtaXreal = 0;
dtaYreal = 0;
// Elevation ASL
dtaElevation = 0;

// Is this the first round (regardless of spotting, FFE or a plotted mission). The first round will take a long time to process, subsequent rounds will take less time.
dtaFirstRound = true;

// Parent classes that show a unit inherits from an artillery piece
dtaArtyParents = ["StaticMortar","StaticCannon","MBT_01_mlrs_base_F","MBT_01_arty_base_F","B_MBT_01_mlrs_base_F","B_MBT_01_arty_base_F","O_MBT_02_arty_base_F","O_MBT_02_arty_F","I_MBT_01_arty_F","I_MBT_01_mlrs_F","rhs_2s3_tv","rhs_bm21_msv_01"];
//dtaArtyParentsRHS = ["rhs_bm21_msv_01","rhs_2s3_tv"];
// Acceptable radio types
dtaRadioTypes = ["ItemRadio"];

dtaSelectedAsset = grpNull;
dtaAssets = [];
dtaWarheadTypes = ["HE","Flare","Smoke","Guided","Cluster","Laser.G","Mine","AT mine","Rockets","WP","Chemical","Nuclear"];
dtaWarheadType = "";
dtaLastWarheadType = "";
dtaRounds = 3;
dtaDispersion = 0;
dtaAngle = "Low";

// Rounds that can be used for airburst fire
dtaAirburstRounds = ["8Rnd_82mm_Mo_Shells","32Rnd_155mm_Mo_shells","RDS_30Rnd_122mmHE_D30","RDS_30Rnd_105mmHE_M119"];
dtaLaserTypes = ["2Rnd_155mm_Mo_LG","RDS_30Rnd_105mmLASER_M119"];
dtaWPTypes = ["DTA_10Rnd_155mm_Mo_wp","RDS_30Rnd_122mmWP_D30","RDS_30Rnd_105mmWP_M119"];
dtaChemTypes = ["1Rnd_155mm_Mo_chem"];
dtaNukeTypes = ["1Rnd_155mm_Mo_nuke"];
dtaGuidedTypes = ["2Rnd_155mm_Mo_guided"];

// For targets of special warhead types
dtaVictimsWP = [];
dtaVictimsChem = [];
dtaVictimsNuke = [];

// New controlled asset
dtaControlledAsset = grpNull;
// Which asset is the player currently controlling
dtaControlledAssetLocal = grpNull;
// All controlled assets
dtaControlledAssets = [];
// All busy assets
dtaAssetsBusy = [];
// Array to be processed on the server
dtaNewFireMission = [];
// Which dialog should be opened by default? ("Assets","Aimpoint","Control")
dtaLastDialog = "Assets";
// Which tube of the selected asset is being used
dtaSelectedTube = objNull;
dtaSelectedTubeIndex = 0;

// Fire mission the player is currently working on
dtaFireMissionCurrent = [];

// What type of mission (FFE = Fire For Effect, SPOT = 1 Spotting round, PLOT = Plot mission, but to not execute it)
dtaMissionType = "";
// All fire missions performed so fare (except spotting rounds)
dtaAllMissions = [];
// Cut down plotting time for repeast or pre-plotted missions
dtaPrePlotted = false;
// Selected pre-plotted mission
dtaSelectedPrePlotted = [];

// Which audio set should each side use (US, Greek, Persian, None)
dtaAudioBLUFOR = "US";
dtaAudioREDFOR = "PER";
dtaAudioINDEP = "GRE";

// Restrict artillery users to certain types and classes?
dtaRestrictUsers = false;
// If so, vehicle classes that are authorized (to be set by script)
dtaAuthorizedClasses = [];
// If so, units that are authorized (to be set by script)
dtaAuthorizedUnits = [];

// Groups, vehicles and classnames that are excluded from the system
dtaExclude = [];

dtaTestShots = 0;
dtaReady = true;
[] execVM "\7cmbgops\scripts\Artillery\Misc\zLoadFunctions.sqf";

// For testing
sleep 1;
if (dtaDebug) then {[] execVM "\7cmbgops\scripts\Artillery\Test\Init.sqf"; hint format ["DTA DEBUG MODE\n\nDRONGO'S ARTILLERY version %1",dtaVersion]; sleep 2; hint ""};