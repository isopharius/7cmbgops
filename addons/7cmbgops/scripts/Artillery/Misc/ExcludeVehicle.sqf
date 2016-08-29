// Excludes a vehicle from the artillery system
while {(time < 4)} do {
	sleep 0.5;
};

dtaExclude pushback _this;
publicVariable "dtaExclude";