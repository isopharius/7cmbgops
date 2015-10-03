ALiVE Command Tablet 0.72
by: SpyderBlack723
-----------------------------------------------
How to install

1. Add the ALiVECommandTablet folder to the root of your mission folder

2, Add the following lines to your description.ext

	#include "ALiVECommandTablet\dialogs.hpp"

	class CfgFunctions
	{
		#include "ALiVECommandTablet\functions\cfgfunctions.hpp"
	};

3. Add the action to the units that you want to have access to the menu

	this addAction ["Tactical Command Interface","CreateDialog 'Spyder_TacticalCommandMain'"];

Be sure to check the example mission if you have troubles inserting it into your mission