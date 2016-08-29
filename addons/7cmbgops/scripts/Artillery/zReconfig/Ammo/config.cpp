#define _ARMA_

//ndefs=13
enum {
	destructengine = 2,
	destructdefault = 6,
	destructwreck = 7,
	destructtree = 3,
	destructtent = 4,
	stabilizedinaxisx = 1,
	stabilizedinaxesxyz = 4,
	stabilizedinaxisy = 2,
	stabilizedinaxesboth = 3,
	destructno = 0,
	stabilizedinaxesnone = 0,
	destructman = 5,
	destructbuilding = 1
};

class CfgAmmo
{
	class ShellCore;
	class ShellBase: ShellCore{};
	class Sh_155mm_AMOS: ShellBase
	{
//		hit = 340;
//		indirectHit = 125;
		hit = 0.1;
		indirectHit = 125;
		indirectHitRange = 30;
//		typicalSpeed = 800;
		explosive = 0.8;
		whistleDist = 60;
	};
	class Sh_82mm_AMOS: Sh_155mm_AMOS
	{
		hit = 165;
		indirectHit = 52;
		indirectHitRange = 18;
	};
};

class Mode_SemiAuto;
class Mode_Burst;
class Mode_FullAuto;

class cfgWeapons
{
	class Default;
	class MGunCore;
	class CannonCore;
	class LauncherCore;
	class RocketPods: LauncherCore{};

	class mortar_82mm: CannonCore
	{
		class Single1: Mode_SemiAuto
		{
//			artilleryDispersion = 1.9;
			artilleryDispersion = 0.00001;
		};
		class Burst1: Mode_Burst
		{
//			artilleryDispersion = 2.2;
			artilleryDispersion = 0.00001;
		};
	};


	class mortar_155mm_AMOS: CannonCore
	{
		class Single1: Mode_SemiAuto
		{
//			artilleryDispersion = 3.2;
			artilleryDispersion = 0.00001;
		};

		class Burst1: Mode_Burst
		{
//			artilleryDispersion = 5.3;
			artilleryDispersion = 0.00001;
		};
	};

	class rockets_230mm_GAT: RocketPods
	{
		class Close: RocketPods
		{
//			artilleryDispersion = 0.5;
			artilleryDispersion = 0.00001;
		};
		class Medium: Close
		{
//			artilleryDispersion = 0.5;
			artilleryDispersion = 0.00001;
		};
		class Far: Close
		{
//			artilleryDispersion = 0.5;
			artilleryDispersion = 0.00001;
		};
		class Full: Close
		{
//			artilleryDispersion = 0.5;
			artilleryDispersion = 0.00001;
		};
	};
};
//};