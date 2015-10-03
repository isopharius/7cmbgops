private ["_operation"];

_operation = lbCurSel 7237;

switch (str (_operation)) do {
	case "-1": {
		hint "You must select a form of analysis first";
	};
	case "0": {
		["client"] spawn STC_fnc_markObjectives;
	};
	case "1": {
		["client"] spawn STC_fnc_markUnits;
	};
};

//-- Disable toggle analysis button and de-select item from list
lbClear 7237;
lbSetCurSel [7237, -1];
_faction = getText (configfile >> "CfgFactionClasses" >> (faction player) >> "displayName");
lbAdd [7237, (format ["%1 commander's orders", _faction])];
lbAdd [7237, "Mark units"];
lbSetTooltip [7237, 0, "Mark objectives and color code them based on your OPCOM's orders; White\Yellow: Unassigned, Green: Idle, Blue: Defend, Red: Attack"];
lbSetTooltip [7237, 1, "Mark all groups on your side"];

ctrlEnable [72314, false];