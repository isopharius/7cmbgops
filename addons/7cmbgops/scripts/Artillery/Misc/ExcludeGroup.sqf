// Excludes a group from the artillery system
while {(time < 4)} do {
	sleep 0.5;
};

dtaExclude pushBack _this;
publicVariable "dtaExclude";